-- USSI Studio - Version Manager
-- Gestione versioni e update

local VersionManager = {}

local CURRENT_VERSION = "0.1.0"
local GITHUB_REPO = "vitogamevirtualmail-tech/UStudio"
local GITHUB_RAW = "https://raw.githubusercontent.com/" .. GITHUB_REPO .. "/main"

function VersionManager:getCurrent()
	return CURRENT_VERSION
end

function VersionManager:getRepositoryUrl()
	return "https://github.com/" .. GITHUB_REPO
end

function VersionManager:getMainUrl()
	return GITHUB_RAW .. "/main.lua"
end

function VersionManager:compareVersions(v1, v2)
	local parts1 = {}
	local parts2 = {}
	
	for part in v1:gmatch("(%d+)") do
		table.insert(parts1, tonumber(part))
	end
	
	for part in v2:gmatch("(%d+)") do
		table.insert(parts2, tonumber(part))
	end
	
	for i = 1, math.max(#parts1, #parts2) do
		local p1 = parts1[i] or 0
		local p2 = parts2[i] or 0
		
		if p1 > p2 then return 1 end
		if p1 < p2 then return -1 end
	end
	
	return 0
end

function VersionManager:isUpdateAvailable(callback)
	-- This would check GitHub for newer version
	-- Placeholder for now
	if callback then
		callback(false, "0.1.0")
	end
end

function VersionManager:printInfo()
	print("\n=== USSI Studio Info ===")
	print("Version: " .. self:getCurrent())
	print("GitHub: " .. self:getRepositoryUrl())
	print("========================\n")
end

return VersionManager
