local m = {}

function m.setup()
  local nl = require("null-ls")

  nl.register({
    require("golang-code-actions.testing"),
    require("golang-code-actions.utils")
  })
end

return m
