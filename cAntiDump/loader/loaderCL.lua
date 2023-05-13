 --╔══════════════════════════════════════════════════╗--
---║           ©cato.dev >> dsc.gg/catodev            ║---
 --╚══════════════════════════════════════════════════╝--

------------------------------------------< function >------------------------------------------
callbackRequest = {}

-- servercallbacks
local Letters = {}
for i = 48,  57 do table.insert(Letters, string.char(i)) end
for i = 65,  90 do table.insert(Letters, string.char(i)) end
for i = 97, 122 do table.insert(Letters, string.char(i)) end

function GetRandomLetter(length)
	Wait(0)
	if length > 0 then
		return GetRandomLetter(length - 1) .. Letters[math.random(1, #Letters)]
	else
		return ''
	end
end

function TriggerCallback(name, ...)
	local requestId = GenerateRequestKey(callbackRequest)
	local response

	callbackRequest[requestId] = function(...)
		response = {...}
	end

	TriggerServerEvent('cLoader:triggerCallback', name, requestId, ...)

	local timeWaited = 0
	while not response do
		timeWaited = timeWaited + 1
		Wait(0)
	end

	return table.unpack(response)
end

function GenerateRequestKey(tbl)
	local id = string.upper(GetRandomLetter(3)) .. math.random(000, 999) .. string.upper(GetRandomLetter(2)) .. math.random(00, 99)

	if not tbl[id] then 
		return tostring(id)
	else
		GenerateRequestKey(tbl)
	end
end

RegisterNetEvent('cLoader:responseCallback')
AddEventHandler('cLoader:responseCallback', function(requestId, ...)
	if callbackRequest[requestId] then 
		callbackRequest[requestId](...)
		callbackRequest[requestId] = nil
	end
end)

------------------------------------------< code >------------------------------------------
local isInjected = false

CreateThread(function()
    while not isInjected do
        code = TriggerCallback('cLoader:getClCode')
        if code then
            assert(load(code))()
            isInjected = true
        end
        Wait(1000)
    end
end)