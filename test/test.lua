textual = require 'textual-torch'

local answer = textual.ping()
if answer == nil then
  error("expected ping to go pong")
else
  print(answer)
end
