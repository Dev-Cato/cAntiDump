-- example server file
CreateThread(function()
    while true do
        print(Config.Example)
        Wait(1000 * 60)
    end
end)