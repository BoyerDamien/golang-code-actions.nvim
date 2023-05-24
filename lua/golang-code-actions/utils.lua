local nl = require("null-ls")

return {
  name = "go-utils",
  method = nl.methods.CODE_ACTION,
  filetypes = { "go" },
  generator = {
    fn = function(params)
      return {
        {
          title = "fill the actual structure",
          action = function()
            print("hello world")
          end
        }
      }
    end
  }
}
