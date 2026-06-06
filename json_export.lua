-- USSI Studio - JSON Export Module
-- Esporta i dati in formato JSON

local JsonExport = {}

function JsonExport:escapeString(str)
	str = str:gsub("\\", "\\\\")
	str = str:gsub('"', '\\"')
	str = str:gsub("\n", "\\n")
	str = str:gsub("\r", "\\r")
	str = str:gsub("\t", "\\t")
	return str
end

function JsonExport:encodeValue(value)
	local t = type(value)
	
	if t == "string" then
		return '"' .. self:escapeString(value) .. '"'
	elseif t == "number" then
		return tostring(value)
	elseif t == "boolean" then
		return value and "true" or "false"
	elseif t == "table" then
		return self:encodeTable(value)
	else
		return "null"
	end
end

function JsonExport:encodeTable(tbl)
	local isArray = true
	local maxIndex = 0

	for key in pairs(tbl) do
		if type(key) ~= "number" then
			isArray = false
			break
		end
		if key > maxIndex then
			maxIndex = key
		end
	end

	if isArray then
		local result = "["
		for i = 1, maxIndex do
			if i > 1 then result = result .. "," end
			result = result .. self:encodeValue(tbl[i])
		end
		result = result .. "]"
		return result
	else
		local result = "{"
		local first = true
		for key, value in pairs(tbl) do
			if not first then result = result .. "," end
			result = result .. '"' .. tostring(key) .. '":' .. self:encodeValue(value)
			first = false
		end
		result = result .. "}"
		return result
	end
end

function JsonExport:encode(data)
	return self:encodeValue(data)
end

return JsonExport
