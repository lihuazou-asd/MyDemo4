GameLevelMgr = Object:subClass("GameLevelMgr")

GameLevelMgr.role = nil
GameLevelMgr.levelInfo = nil
GameLevelMgr.monsters = nil
GameLevelMgr.nowLevel = 1

function GameLevelMgr:Init(role,levelInfo,monsters)
    self.role = role
    self.levelInfo = levelInfo
    self.monsters = monsters



end

function GameLevelMgr:NextLevel(id)

end

function GameLevelMgr:ShowChoosePanel()


end



