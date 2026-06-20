return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    local ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'java',
      'javascript',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    }

    require('nvim-treesitter').install(ensure_installed)

    if vim.treesitter.language and vim.treesitter.language.register then
      vim.treesitter.language.register('tsx', 'javascriptreact')
      vim.treesitter.language.register('bash', 'dotenv')
    end

    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    -- If you are experiencing weird indenting issues, add the language to the
    -- list of additional_vim_regex_highlighting and skip enabling treesitter indent for it.
    local additional_vim_regex_highlighting = { 'ruby' }
    local indent_disabled = { 'ruby' }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local ok = pcall(vim.treesitter.start, args.buf)
        if not ok then
          return
        end

        if vim.tbl_contains(additional_vim_regex_highlighting, ft) then
          vim.bo[args.buf].syntax = 'on'
        end

        if not vim.tbl_contains(indent_disabled, ft) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dotenv',
      callback = function(args)
        vim.bo[args.buf].commentstring = '# %s'
      end,
    })

    -- Treat Fastlane files as Ruby
    vim.filetype.add({
      filename = {
        Fastfile = 'ruby',
        Appfile = 'ruby',
        Matchfile = 'ruby',
        Gymfile = 'ruby',
        Scanfile = 'ruby',
        Deliverfile = 'ruby',
        Pluginfile = 'ruby',
        Snapfile = 'ruby',
        ['.env'] = 'dotenv',
        ['.envrc'] = 'sh',
        env = 'dotenv',
        envrc = 'sh',
      },
      pattern = {
        ['%.env%..+'] = 'dotenv',
        ['env%..+'] = 'dotenv',
      },
    })
  end,
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
