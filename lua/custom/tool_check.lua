local M = {}

M.runtime_by_tool = {
  ['bash-language-server'] = 'node',
  ['checkstyle'] = 'java',
  ['eslint_d'] = 'node',
  ['jdtls'] = 'java',
  ['jsonlint'] = 'node',
  ['markdownlint'] = 'node',
  ['prettier'] = 'node',
  ['prettierd'] = 'node',
  ['typescript-language-server'] = 'node',
  ts_ls = 'node',
  bashls = 'node',
}

function M.available(tool)
  return vim.fn.executable(tool) == 1
end

function M.runtime_ok(tool)
  local rt = M.runtime_by_tool[tool]
  return rt == nil or vim.fn.executable(rt) == 1
end

function M.filter(tools)
  return vim.tbl_filter(M.runtime_ok, tools)
end

function M.missing_runtimes(tools)
  local seen, missing = {}, {}
  for _, tool in ipairs(tools) do
    local rt = M.runtime_by_tool[tool]
    if rt and not seen[rt] and vim.fn.executable(rt) ~= 1 then
      seen[rt] = true
      table.insert(missing, rt)
    end
  end
  return missing
end

return M
