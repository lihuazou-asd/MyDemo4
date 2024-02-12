GameLevelMgr = Object:subClass("GameLevelMgr")

function GameLevelMgr:Awake()

end
function GameLevelMgr:Start()

end
function GameLevelMgr:Update()


    if self.isBattle then
        self.Time = self.Time + Time.deltaTime
        if self.nowWave > self.nowLevelMaxWave then
            return
        else 
            if self.Time > self.waveInfo[self.nowLevel][self.nowWave].time then
                self.luaObj:StartCoroutine(util.cs_generator(function() self:GenerateMonsterCoroutine(self.waveInfo[self.nowLevel][self.nowWave].totalNums)  end))
                self.nowWave = self.nowWave+1
            end
        end
        if self.Time > self.levelInfo[self.nowLevel].time or self.levelInfo[self.nowLevel].num then
            self.isBattle = false
            self.Time = 0
        end
    end
    
end
function GameLevelMgr:FixedUpdate()

end
function GameLevelMgr:LateUpdate()

end
function GameLevelMgr:OnEnable()

end
function GameLevelMgr:OnDisable()

end
function GameLevelMgr:OnDestroy()

end

GameLevelMgr.role = nil
GameLevelMgr.levelInfo = nil
GameLevelMgr.monstersInfo = nil
GameLevelMgr.nowLevel = 1
GameLevelMgr.nowWave = 1
GameLevelMgr.waveInfo = {}
GameLevelMgr.killMonster = 0
GameLevelMgr.luaObj = nil
GameLevelMgr.Time = 0;
GameLevelMgr.obj = nil
GameLevelMgr.isBattle = nil
GameLevelMgr.nowLevelMaxWave = 0


function GameLevelMgr:Init(obj,role,levelInfo,monstersInfo)
    self.Time = 0
    self.obj = obj
    self.role = role
    self.levelInfo = levelInfo
    self.nowLevel = 1
    self.monstersInfo = monstersInfo
    self.nowWave = 1
    self.killMonster = 0
    self.waveInfo = {}
    self.isBattle = true
    for i = 1,#self.levelInfo do
        self.waveInfo[i] = GameDataMgr:InfosDeCode("json","WaveInfo_"..i,typeof(TextAsset))
    end
    self.nowLevelMaxWave = #self.waveInfo[1]
    self.luaObj = self.obj:AddComponent(typeof(LuaMonoObj))
    self.luaObj:AddOrRemoveListener(function() self:Update() end,E_LifeFun_Type.Update)




end

function GameLevelMgr:NextLevel(id)

end

function GameLevelMgr:UpdateWave()


end
function GameLevelMgr:GenerateMonsterCoroutine(monsterNums)
    print("进入协程")
    local genedMonsterNum = 1
    local monsterType = string.split(self.waveInfo[self.nowLevel][self.nowWave].monsterId,"|")
    local monsterTypeNums = string.split(self.waveInfo[self.nowLevel][self.nowWave].num,"|")
    local nowType = 1
    while genedMonsterNum  <= monsterNums do
        if self.isBattle then
            self:GenerateMonster(monsterType[nowType])
            monsterTypeNums[nowType] = monsterTypeNums[nowType] - 1
            if monsterTypeNums[nowType]== 0 then
                nowType = nowType +1
            end
            genedMonsterNum = genedMonsterNum + 1
            coroutine.yield(WaitForSeconds(1))
        end
    end

end

function GameLevelMgr:GenerateMonster(id)
    print(id)
end

function GameLevelMgr:ShowChoosePanel()


end



