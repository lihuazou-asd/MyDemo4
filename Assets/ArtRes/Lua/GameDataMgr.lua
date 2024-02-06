Object:subClass("GameDataMgr")

GameDataMgr = _G["GameDataMgr"]

GameDataMgr.PlayerInfos = nil
GameDataMgr.MusicData = nil

function GameDataMgr:Init()
    GameDataMgr.PlayerInfos = GameDataMgr:PlayerInfosDeCode("json","PlayerInfos",typeof(TextAsset))
    
end

function GameDataMgr:PlayerInfosDeCode(luaName,resName,type)
    local txt = ABMgr:LoadRes(luaName,resName,type)
    local playList = Json.decode(txt.text)
    local PlayerInfo = {}
    for _, value in pairs(playList) do
        PlayerInfo[value.id] = value
    end
    return PlayerInfo
end
