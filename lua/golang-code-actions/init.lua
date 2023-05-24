local m = {}

function m.setup()
  local nl = require("null-ls")

  nl.register({
    require("golang-code-actions.testing"),
  })
end

return m
