local colors = {
  background = 'NONE',
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local function spacer()
  return {
    function()
      return ' '
    end,
    color = { fg = colors.background, bg = colors.background },
  }
end

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

local git_diff_cache = {}

local function update_git_diff(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local filename = vim.api.nvim_buf_get_name(bufnr)
  local root = filename ~= '' and vim.fs.root(bufnr, '.git')
  local relative = root and vim.fs.relpath(root, filename)
  if not root or not relative or vim.fn.executable('git') ~= 1 then
    git_diff_cache[bufnr] = { added = 0, modified = 0, removed = 0 }
    return
  end

  vim.system({ 'git', '-C', root, 'diff', 'HEAD', '--no-color', '--no-ext-diff', '-U0', '--', relative }, { text = true }, function(result)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(bufnr) or result.code ~= 0 then
        return
      end

      local added, modified, removed = 0, 0, 0
      for line in (result.stdout or ''):gmatch('[^\n]+') do
        local _, old_count, _, new_count = line:match('^@@ %-([0-9]+),?([0-9]*) %+([0-9]+),?([0-9]*) @@')
        if old_count then
          local old_lines, new_lines = tonumber(old_count) or 1, tonumber(new_count) or 1
          if old_lines == 0 then
            added = added + new_lines
          elseif new_lines == 0 then
            removed = removed + old_lines
          else
            local changed = math.min(old_lines, new_lines)
            modified = modified + changed
            added = added + new_lines - changed
            removed = removed + old_lines - changed
          end
        end
      end

      git_diff_cache[bufnr] = { added = added, modified = modified, removed = removed }
      require('lualine').refresh()
    end)
  end)
end

local diff_group = vim.api.nvim_create_augroup('LualineGitDiff', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'FileChangedShellPost', 'FocusGained' }, {
  group = diff_group,
  callback = function(args)
    update_git_diff(args.buf)
  end,
})
vim.api.nvim_create_autocmd('User', {
  group = diff_group,
  pattern = 'GitSignsUpdate',
  callback = function(args)
    update_git_diff(args.data and args.data.buffer or vim.api.nvim_get_current_buf())
  end,
})
update_git_diff(vim.api.nvim_get_current_buf())

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { { 'mode', icon = ' ', separator = { left = '', right = '' }, right_padding = 2 } },
    lualine_b = {
      spacer(),
      { 'filename', icon = ' ', separator = { left = '', right = '' }, color = { fg = colors.white, bg = colors.grey }, left_padding = 1, right_padding = 1 },
      spacer(),
      {
        'diff',
        icon = ' ',
        source = function()
          return git_diff_cache[vim.api.nvim_get_current_buf()] or { added = 0, modified = 0, removed = 0 }
        end,
        fmt = function(status)
          return status == '' and 'clean' or status
        end,
        separator = { left = '', right = '' },
        color = { fg = colors.white, bg = colors.grey },
        left_padding = 1,
        right_padding = 1,
      },
    },
    lualine_c = {
      spacer(),
      { 'Progress', icon = '󰦖 ', separator = { left = '', right = '' }, color = { fg = colors.white, bg = colors.grey }, left_padding = 1, right_padding = 1 },
    }, lualine_x = {
    spacer(),
    {
      function()
        local msg = "No LSP"
        local buf_nr = vim.api.nvim_get_current_buf()
        local buf_ft = vim.bo.filetype
        local clients = vim.lsp.get_clients { bufnr = buf_nr }
        local lsp_short_names = {
          pyright = "py",
          tsserver = "ts",
          rust_analyzer = "rs",
          lua_ls = "lua",
          clangd = "c++",
          bashls = "sh",
          jsonls = "json",
          html = "html",
          cssls = "css",
          tailwindcss = "tw",
          dockerls = "docker",
          sqlls = "sql",
          yamlls = "yml",
        }
        local names = {}
        -- Add active LSP clients
        for _, client in ipairs(clients) do
          if client.name ~= "null-ls" then
            table.insert(names, lsp_short_names[client.name] or client.name)
          end
        end
        -- Add linters from nvim-lint
        local lint_ok, lint = pcall(require, "lint")
        if lint_ok and lint.linters_by_ft then
          local linters = lint.linters_by_ft[buf_ft]
          if type(linters) == "table" then
            for _, linter in ipairs(linters) do
              table.insert(names, linter)
            end
          elseif type(linters) == "string" then
            table.insert(names, linters)
          end
        end
        -- Add formatters from conform.nvim
        local conform_ok, conform = pcall(require, "conform")
        if conform_ok and conform.list_formatters_for_buffer then
          local formatters = conform.list_formatters_for_buffer()
          for _, formatter in ipairs(formatters) do
            table.insert(names, formatter)
          end
        end
        -- Remove duplicates
        local seen = {}
        local unique = {}
        for _, name in ipairs(names) do
          if not seen[name] then
            table.insert(unique, name)
            seen[name] = true
          end
        end
        if #unique == 0 then
          return msg
        end
        return "[" .. table.concat(unique, ", ") .. "]"
      end,
      icon = '󰙳 ',
      separator = { left = '', right = '' },
      color = function()
        local buf_nr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients { bufnr = buf_nr }

        local has_lsp = false
        for _, client in ipairs(clients) do
          if client.name ~= "null-ls" then
            has_lsp = true
            break
          end
        end

        if has_lsp then
          return { fg = colors.black, bg = colors.cyan, gui = "bold" }
        else
          return { fg = colors.white, bg = colors.grey, gui = "bold" }
        end
      end,
    },
  },
    lualine_y = {
      spacer(),
      { 'branch', icon = ' ', separator = { left = '', right = '' }, color = { fg = colors.white, bg = colors.grey }, left_padding = 1, right_padding = 1 },
      spacer(),
      'diagnostics',
      { 'filetype', separator = { left = '', right = '' }, color = { fg = colors.white, bg = colors.grey }, left_padding = 1, right_padding = 1 },
    },
    lualine_z = {
      spacer(),
      { 'location', separator = { left = '', right = '' }, color = { fg = colors.black, bg = colors.violet }, left_padding = 1, right_padding = 1 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

local function clear_statusline_background()
  vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE' })
end

clear_statusline_background()
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('LualineTransparentStatusline', { clear = true }),
  callback = clear_statusline_background,
})
