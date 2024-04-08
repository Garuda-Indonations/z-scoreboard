--[[ Need Help? Join my discord @ discord.gg/yWddFpQ ]]

local nui = false
local key = 20
local players = GlobalState["players"] or {}

Citizen.CreateThread(function()
    while true do
        Wait(1000)

        players = GlobalState["players"]
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if IsControlPressed(0, key) then
            if not nui then
                local playerList = {}
                for _, player in pairs(players) do
                    table.insert(playerList,
                        '<tr style=\"color: #fff"><td>' ..
                        player.id .. '</td><td>' .. player.name .. '</td></tr>'
                    )
                end

                SendNUIMessage({ text = table.concat(playerList) })

                nui = true
                while nui do
                    Wait(0)
                    if (IsControlPressed(0, key) == false) then
                        nui = false
                        SendNUIMessage({
                            meta = 'close'
                        })
                        break
                    end
                end
            end
        end
    end
end)
