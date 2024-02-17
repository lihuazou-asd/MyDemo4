GameLevelMgr = Object:subClass("GameLevelMgr")

function GameLevelMgr:Awake()

end
function GameLevelMgr:Start()

end
function GameLevelMgr:Update()
    if self.isBattle then
        self.Time = self.Time + Time.deltaTime
        if self.nowWave <= self.nowLevelMaxWave and self.Time > self.waveInfo[self.nowLevel][self.nowWave].time then
            local tmpWave = self.nowWave
            self.luaObj:StartCoroutine(util.cs_generator(function() self:GenerateMonsterCoroutine(self.waveInfo[self.nowLevel][self.nowWave].totalNums,tmpWave)  end))
            self.nowWave = self.nowWave+1
        end
        if self.levelInfo[self.nowLevel].nums == self.killMonster or self.Time > self.levelInfo[self.nowLevel].time then
            self.luaObj:StartCoroutine(util.cs_generator(function() self:DelayVectory(1) end))
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

GameLevelMgr.roleControl = nil
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

GameLevelMgr.BagIcon = {}


function GameLevelMgr:Init(obj,roleControl,levelInfo,monstersInfo)
    self.Time = 0
    self.obj = obj
    self.roleControl = roleControl
    self.levelInfo = levelInfo
    self.nowLevel = 1
    self.monstersInfo = monstersInfo
    self.nowWave = 1
    self.killMonster = 0
    self.waveInfo = {}
    self.BagIcon = {}
    self.isBattle = true
    for i = 1,#self.levelInfo do
        self.waveInfo[i] = GameDataMgr:InfosDeCode("json","WaveInfo_"..i,typeof(TextAsset))
    end
    self.nowLevelMaxWave = #self.waveInfo[1]
    self.luaObj = self.obj:AddComponent(typeof(LuaMonoObj))
    self.luaObj:AddOrRemoveListener(function() self:Update() end,E_LifeFun_Type.Update)
end

function GameLevelMgr:NextLevel()
    self.nowLevel = self.nowLevel+1
    self.Time = 0
    self.killMonster = 0
    self.nowWave = 1
    self.roleControl:InitState()
    UIMgr:GetPanel("GamePanel"):InitState()
    self.isBattle = true
    self.roleControl.isControl = true
    
end

function GameLevelMgr:UpdateWave()


end
function GameLevelMgr:GenerateMonsterCoroutine(monsterNums,waveId)
    print("进入协程")
    local genedMonsterNum = 1
    local monsterType = string.split(self.waveInfo[self.nowLevel][waveId].monsterId,"|")
    local monsterTypeNums = string.split(self.waveInfo[self.nowLevel][waveId].num,"|")
    local nowType = 1
    while genedMonsterNum  <= monsterNums do
        if self.isBattle then
            print(monsterType[nowType])
            self:GenerateMonster(monsterType[nowType],self.waveInfo[self.nowLevel][waveId].pos,self.roleControl.obj,self.roleControl)
            monsterTypeNums[nowType] = monsterTypeNums[nowType] - 1
            if monsterTypeNums[nowType]== 0 then
                nowType = nowType +1
            end
            genedMonsterNum = genedMonsterNum + 1
            coroutine.yield(WaitForSeconds(1))
        end
    end
end

function GameLevelMgr:GenerateMonster(id,pos,roleObj,roleControl)
    local monsterControl = MonsterControl:new()
    local tmpPos = string.split(pos,":")
    monsterControl:Init(id,tmpPos,roleObj,roleControl)
end

function GameLevelMgr:DelayVectory(time)
    if self.nowLevel < #self.levelInfo then
        self.isBattle = false
        eventCenter:triggerEvent("TimeOut")
        coroutine.yield(WaitForSeconds(time))
        self.roleControl.isControl= false
        print("战斗停止")
        self.Time = 0
        UIMgr:ShowPanel("ChoosePanel")
    else
        self.isBattle = false
        eventCenter:triggerEvent("TimeOut")
        coroutine.yield(WaitForSeconds(time))
        self.roleControl.isControl= false
        print("顺利通关")
    end
    
end

function GameLevelMgr:AddBagIcon(id)
    if self.BagIcon[id] ~= nil then
        self.BagIcon[id].num = self.BagIcon[id].num +1
        self.BagIcon[id].control:ChangeNum(self.BagIcon[id].num)
    else
        self.BagIcon[id] = {}
        self.BagIcon[id].num = 1
        UIMgr:GetPanel("ChoosePanel"):AddBagGrid(id)
        
    end
end