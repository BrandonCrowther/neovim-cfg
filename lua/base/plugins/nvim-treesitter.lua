return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = {
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
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    if vim.treesitter.language and vim.treesitter.language.register then
      vim.treesitter.language.register('tsx', 'javascriptreact')
      vim.treesitter.language.register('bash', 'dotenv')
    end

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
