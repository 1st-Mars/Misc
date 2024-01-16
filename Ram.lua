local RAMAccount = loadstring(game:HttpGet'https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RAMAccount.lua')()
local idk = {
    ["RAM_Track"] = true,
}
local MyAccount = RAMAccount.new(game:GetService'Players'.LocalPlayer.Name)
function CheckPlayerDF()
    local cS
    local cT
    if table.find(Raids2, khongngu22(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value)) then
        cS = {}
        AwakedSkills = {}
        getAwakenedAbilities = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getAwakenedAbilities")
        for r, v in pairs(getAwakenedAbilities) do
            table.insert(cS, r)
            if v["Awakened"] then
                table.insert(AwakedSkills, r)
            end
        end
    end
    if cS then
        if AwakedSkills and #AwakedSkills ~= #cS then
            cT = tostring(getPersent(#AwakedSkills, #cS)) .. "% " .. tostring("V2")
        elseif AwakedSkills and #AwakedSkills == #cS then
            cT = "V2"
        elseif not AwakedSkills then
            cT = "V1"
        end
    end
    DF = game.Players.LocalPlayer.Data.DevilFruit.Value
    if not cT then
        DF = DF .. " | Mastery: " .. getFruitMastery()
    else
        DF = DF .. " " .. cT .. " | " .. #AwakedSkills .. " | Mastery: " .. getFruitMastery()
    end
    return DF
end
function getInventoryFruits()
    ss = {}
    for k, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do
        if v["Type"] == "Blox Fruit" then
            table.insert(ss, v["Value"])
        end
    end
    mem = ""
    for r, v in pairs(ss) do
        s2 = getMaxOfNumbers(ss)
        for k, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do
            if v["Type"] == "Blox Fruit" and v["Value"] == s2 then
                mem = mem .. v["Name"] .. ", "
            end
        end
        removechildintable(ss, s2)
    end
    return mem
end
local cj = MyAccount.new(game:GetService "Players".LocalPlayer.Name)
if not idk["RAM_Track_Delay"] then
    idk["RAM_Track_Delay"] = 90
end
spawn(
    function()
        while wait() do
            if idk["RAM_Track"] then
                if not idk["RAM_Track_Delay"] then
                    idk["RAM_Track_Delay"] = 90
                end
                DFStorage = getInventoryFruits()
                Alias = 'AVN Sercurity'
                Description = "Fruit Store : ".. getInventoryFruits() .. "\nPlayers Fruits : " .. CheckPlayerDF()
                cj:SetAlias(Alias)
                cj:SetDescription(Description)
                wait(idk["RAM_Track_Delay"])
            end
        end
    end
)

