return function(looky)
  return {
    build = function(options)
      local container = looky:build("image", { width = "wrap", height = "wrap", background = { file = messages.bubble, fill = "fit" }, file = messages.attack })
      container.path = options.path
      container.target = options.target
      container.msg = options.msg
      return container
    end,
    schema = {      
      target = {
        required = true,
        schemaType = "table",
        options = {},
        allowOther = true
      },
      msg = {
        required = true,
        schemaType = "string"
      },
      path = {
        required = true,
        schemaType = "array",
        item = {
          schemaType = "table",
          options = {
            {
              required = true,
              schemaType = "number"
            },
            {
              required = true,
              schemaType = "number"
            }
          }
        }
      }
    }
  }
end