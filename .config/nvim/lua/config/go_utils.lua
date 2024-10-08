local M = {}

-- Function to switch to the corresponding test file
function M.switch_to_test()
  local current_file = vim.fn.expand("%:p")
  local test_file = current_file:gsub("%.go$", "_test.go")

  if vim.fn.filereadable(test_file) == 1 then
    vim.cmd("edit " .. test_file)
  else
    print("Test file not found: " .. test_file)
  end
end

-- Function to switch to the corresponding test file in a vertical split
function M.switch_to_test_vsplit()
  local current_file = vim.fn.expand("%:p")
  local test_file = current_file:gsub("%.go$", "_test.go")

  if vim.fn.filereadable(test_file) == 1 then
    vim.cmd("vsplit " .. test_file)
  else
    print("Test file not found: " .. test_file)
  end
end

-- Function to switch to the corresponding source file
function M.switch_to_source()
  local current_file = vim.fn.expand("%:p")
  local source_file = current_file:gsub("_test%.go$", ".go")

  if vim.fn.filereadable(source_file) == 1 then
    vim.cmd("edit " .. source_file)
  else
    print("Source file not found: " .. source_file)
  end
end

return M
