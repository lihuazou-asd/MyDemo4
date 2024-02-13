Object:subClass("GameDataMgr")

GameDataMgr = _G["GameDataMgr"]

GameDataMgr.PlayerInfos = {}
GameDataMgr.MusicData = {bgmData = 50,btmData = 50}
GameDataMgr.MonsterInfos = {}

function GameDataMgr:Init()
    GameDataMgr.PlayerInfos = GameDataMgr:InfosDeCode("json","PlayerInfos",typeof(TextAsset))
    GameDataMgr.MonsterInfos = GameDataMgr:InfosDeCode("json","MonsterInfo",typeof(TextAsset))
    local tmpStr = self:ReadText(persistentDataPath.."/MusicData.json","r")
    if tmpStr~=nil then
        GameDataMgr.MusicData = Json.decode(tmpStr)
    end
end

function GameDataMgr:InfosDeCode(luaName,resName,type)
    local txt = ABMgr:LoadRes(luaName,resName,type)
    local playList = Json.decode(txt.text)
    local PlayerInfo = {}
    for _, value in pairs(playList) do
        PlayerInfo[value.id] = value
    end
    return PlayerInfo
end


function GameDataMgr:ReadText(path,operate)
    local file = io.open(path, operate)
    if file then
        local content = file:read("*all")
        file:close()
        return content
    else
        print("File does not exist")
        return nil
    end

end
function GameDataMgr:WriteText(path,operate,str)
    local file = io.open(path,operate)
    if file then
        file:write(str)
        file:close()
        print("File written successfully")
    else
        print("Failed to open file for writing")
    end
end




