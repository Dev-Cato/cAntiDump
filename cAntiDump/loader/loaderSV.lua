 --╔══════════════════════════════════════════════════╗--
---║           ©cato.dev >> dsc.gg/catodev            ║---
 --╚══════════════════════════════════════════════════╝--

------------------------------------------< function >------------------------------------------
Callbacks = {}

function RegisterCallback(name, cb)
	Callbacks[name] = cb
end

RegisterNetEvent('cLoader:triggerCallback')
AddEventHandler('cLoader:triggerCallback', function(name, requestId, ...)
	local src = source
	if Callbacks[name] then
		Callbacks[name](src, function(...)
			TriggerClientEvent('cLoader:responseCallback', src, requestId, ...)
		end, ...)
	end
end)

------------------------------------------< code >------------------------------------------

RegisterCallback('cLoader:getClCode', function(source, cb)
    local loader = "\112\114\105\110\116\40\39\94\52\39\32\46\46\32\71\101\116\67\117\114\114\101\110\116\82\101\115\111\117\114\99\101\78\97\109\101\40\41\32\46\46\32\39\94\55\32\108\111\97\100\101\100\32\98\121\32\94\52\99\97\116\111\46\100\101\118\94\55\39\41\n"

    local configFile = io.open(GetResourcePath(GetCurrentResourceName()) .. "/config.lua", "a+")
    local configLines = {}
    for line in configFile:lines() do
        table.insert(configLines, line)
    end

    local clientFile = io.open(GetResourcePath(GetCurrentResourceName()) .. "/client.lua", "a+")
    local clientLines = {}
    for line in clientFile:lines() do
        table.insert(clientLines, line)
    end

    local code = loader .. table.concat(configLines, "\n") .. "\n\n" .. table.concat(clientLines, "\n")

    if code == nil then
        code = ""
	end
	cb(code)
end)


function getStringBytes(str)
    local byteStr = ""
    for i = 1, string.len(str) do

        byteStr = byteStr .. "\\" .. string.byte(str, i)
    end
    return byteStr
end
