local nl = require("null-ls")

return {
  name = "testing-go",
  method = nl.methods.CODE_ACTION,
  filetypes = { "go" },
  generator = {
    fn = function(params)
      return {
        {
          title = "generate test for all functions",
          action = function()
            local file_name = vim.fn.fnamemodify(vim.fn.expand('%:t'), ":r") .. "_test.go"
            local cmd = "! gotests -all -w " .. file_name .. " " .. params.bufname
            vim.cmd(cmd)
          end
        },
        {
          title = "generate test for one function",
          action = function()
            local ts_utils = require("nvim-treesitter.ts_utils")
            local node = ts_utils.get_node_at_cursor()
            if node == nil then
              vim.notify("Empty node: please install a treesitter parser for this language")
            else
              local start_row = node:start()
              local parent = node:parent()

              -- Loop until find root node
              while (parent ~= nil and parent:start() == start_row) do
                node = parent
                parent = node:parent()
              end

              local node_name = ts_utils.get_node_text(node:child(1))[1]
              local file_name = vim.fn.fnamemodify(vim.fn.expand('%:t'), ":r") .. "_test.go"
              local cmd = "! gotests -only " ..
                  "\"^" .. node_name .. "$\" -w " .. file_name .. " " .. params.bufname
              vim.cmd(cmd)
            end
          end
        }
      }
    end
  }
}
