-- USSI Studio - Xeno Executor Universal Loader
-- Funziona su tutti gli executor con fallback

local function loadUSSI()
	local url = "https://raw.githubusercontent.com/vitogamevirtualmail-tech/UStudio/main/main.lua"
	local code
	local success = false
	
	-- Tentativo 1: HttpService:GetAsync (più compatibile)
	if not success then
		local ok, result = pcall(function()
			code = game:GetService("HttpService"):GetAsync(url)
			return true
		end)
		if ok and result then
			success = true
			print("[USSI] ✅ Caricato con HttpService")
		end
	end
	
	-- Tentativo 2: game:HttpGet con true
	if not success then
		local ok, result = pcall(function()
			code = game:HttpGet(url, true)
			return true
		end)
		if ok and result then
			success = true
			print("[USSI] ✅ Caricato con game:HttpGet")
		end
	end
	
	-- Tentativo 3: game:HttpGet senza parametri
	if not success then
		local ok, result = pcall(function()
			code = game:HttpGet(url)
			return true
		end)
		if ok and result then
			success = true
			print("[USSI] ✅ Caricato con game:HttpGet (base)")
		end
	end
	
	if not success or not code then
		print("[USSI] ❌ Errore: Nessun metodo di caricamento disponibile")
		print("[USSI] Prova a copiare il codice direttamente da:")
		print("[USSI] https://raw.githubusercontent.com/vitogamevirtualmail-tech/UStudio/main/main.lua")
		return false
	end
	
	-- Carica il codice
	local loadOk, loadErr = pcall(function()
		loadstring(code)()
	end)
	
	if not loadOk then
		print("[USSI] ❌ Errore nell'esecuzione: " .. loadErr)
		return false
	end
	
	return true
end

-- Esegui
local success = loadUSSI()
if success then
	print("[USSI] ✅ USSI Studio caricato con successo!")
else
	print("[USSI] ⚠️  Caricamento fallito. Leggi i messaggi sopra.")
end
