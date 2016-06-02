local textual = {}

local plfile = require 'pl.file'
local stringx = require 'pl.stringx'

--------------------
-- Utility functions
--------------------

-- Silly way to test that the library was loaded.
function textual.ping()
  return "pong"
end

-- Convenience function that works like tensor:max(1) but returns the 
-- tuple (max,maxIndex) rather than tensors containing these.
function textual.whichMax(vec)
  local vecMax, maxIndex = vec:max(1)
  return vecMax[1], maxIndex[1]
end

function textual.splitUnicode(s)
  local chars = {}
  local i=1
  for c in s:gmatch(".[\128-\191]*") do
    chars[i] = c
    i = i + 1
  end
  return chars
end

function textual.readLines(fn)
  return stringx.splitlines(plfile.read(fn))
end

-- If `lookupTable` is missing a value the value
-- `missing` is used.
function textual.translate(toTrans, lookupTable, missing)
  local translated = lookupTable[toTrans] or missing
  if translated == nil then
    error("untranslateable item: " .. toTrans)
  end
  return translated
end

-- This function assumes that v will be indexed in [1,numCategories], it can either be
-- a 1D tensor, or a single number. If it's a single nubmer the result will be a 1D tensor.
-- If it's either a vector or a matrix, the result will be a 2D tensor.
function textual.oneHot(v,numCategories)
  local len, nDim
  if type(v) == "number" then
    len = 1
    nDim = 0
  else
    len = v:size(1)
    nDim = v:dim()
  end
  local mx = torch.zeros(len, numCategories)
  if nDim > 2 then
    error("Must be vector or matrix")
  end
  for i=1,len do
    local val
    if nDim == 0 then
      val = v
    elseif nDim == 1 then
      val = v[i]
    else
      val = v[i][1]
    end
    mx[i][val] = 1
  end
  if nDim == 0 then
    return mx:view(-1)
  end
  return mx
end

function textual.oneHotInverse(v)
  local one, idx = textual.whichMax(v)
  return idx
end

return textual
