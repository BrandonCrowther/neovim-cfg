return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      local tool_check = require 'custom.tool_check'

      lint.linters_by_ft = {}

      local function add_linter(ft, linter)
        if tool_check.available(linter) then
          lint.linters_by_ft[ft] = lint.linters_by_ft[ft] or {}
          table.insert(lint.linters_by_ft[ft], linter)
        end
      end

      if tool_check.available 'markdownlint' then
        lint.linters.markdownlint.args = {
          '--stdin',
          '--config',
          vim.fn.stdpath 'config' .. '/config/linters/markdownlint.json',
        }
      end

      if tool_check.available 'yamllint' then
        lint.linters.yamllint.args = {
          '--config-file',
          vim.fn.stdpath 'config' .. '/config/linters/yamllint.yaml',
          '-',
        }
      end

      if tool_check.available 'checkstyle' then
        local root_markers = { '.git', 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', 'settings.gradle.kts' }

        lint.linters.checkstyle.args = {
          '-f',
          'sarif',
          '-c',
          function()
            local buf_path = vim.api.nvim_buf_get_name(0)
            local root = vim.fs.root(buf_path ~= '' and buf_path or 0, root_markers) or vim.fn.getcwd()
            return root .. '/src/main/resources/checkstyle/checkstyle.xml'
          end,
        }
      end

      add_linter('markdown', 'markdownlint')
      add_linter('javascript', 'eslint_d')
      add_linter('typescript', 'eslint_d')
      add_linter('javascriptreact', 'eslint_d')
      add_linter('typescriptreact', 'eslint_d')
      add_linter('dockerfile', 'hadolint')
      add_linter('dockerfile', 'trivy')
      if tool_check.available 'dotenv-linter' then
        add_linter('dotenv', 'dotenv_linter')
      end
      add_linter('json', 'jsonlint')
      add_linter('terraform', 'tflint')
      add_linter('terraform', 'tfsec')
      add_linter('terraform', 'trivy')
      add_linter('yaml', 'yamllint')
      add_linter('yaml', 'trivy')
      add_linter('java', 'checkstyle')

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable and (lint.linters_by_ft[vim.bo.filetype] ~= nil) then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
