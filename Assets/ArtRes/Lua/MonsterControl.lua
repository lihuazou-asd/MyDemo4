MonsterControl = Object:subClass("MonsterControl")


function MonsterControl:Awake()

end
function MonsterControl:Start()

end
function MonsterControl:Update()
    if self.isDead == false then
        self.AtkTimeOffset = self.AtkTimeOffset+Time.deltaTime
        self.DistanceWithRoleXY = {x = self.obj.transform.position.x-self.roleObj.transform.position.x,y = self.obj.transform.position.y-self.roleObj.transform.position.y}
        self.DistanceWithRole = math.sqrt((self.DistanceWithRoleXY.x)^2+(self.DistanceWithRoleXY.y)^2)
        if self.roleControl.nearMonsterControl==nil or self.roleControl.nearMonsterControl.DistanceWithRole>self.DistanceWithRole then
            self.roleControl.nearMonsterControl = self
        end
        if self.DistanceWithRole<self.AtkRange and self.AtkTimeOffset>=self.AtkDelay then
            self.AtkTimeOffset=0
            self.animator:SetTrigger("Atk")
        end
        self.direction = (self.roleObj.transform.position - self.obj.transform.position).normalized
        self.obj.transform:Translate(self.direction*Time.deltaTime*self.Speed,Space.self)
        self.spriteRenderer.flipX = self.direction.x>0
    else 
        self.animator:SetBool("Dead",self.isDead)
        self.roleControl.nearMonsterControl = nil
    end
end
function MonsterControl:FixedUpdate()

end
function MonsterControl:LateUpdate()

end
function MonsterControl:OnEnable()

end
function MonsterControl:OnDisable()

end
function MonsterControl:OnDestroy()

end

MonsterControl.id = nil
MonsterControl.roleObj = nil
MonsterControl.obj = nil
MonsterControl.bornPos = nil
MonsterControl.luaObj = nil
MonsterControl.animator = nil
MonsterControl.spriteRenderer = nil
MonsterControl.state = {atk = nil,bld = nil}
MonsterControl.Speed = 5
MonsterControl.direction = nil
MonsterControl.isDead = false
MonsterControl.AtkTimeOffset = 0
MonsterControl.AtkDelay = 1
MonsterControl.AtkRange = 4

MonsterControl.DistanceWithRoleXY = nil

MonsterControl.roleControl = nil


MonsterControl.DistanceWithRole = nil

function MonsterControl:Init(id,pos,roleObj,roleControl)
    self.roleControl = roleControl
    self.AtkTimeOffset = 0;
    self.DistanceWithRole = nil
    self.DistanceWithRoleXY = {}
    self.direction = nil
    self.id = tonumber(id)
    self.roleObj = roleObj
    self.bornPos = pos
    self.isDead = false
    local screenPos = Vector3(MainCameraComponent.pixelWidth * self.bornPos[1], MainCameraComponent.pixelHeight * self.bornPos[2],0)
    local worldPos = MainCameraComponent:ScreenToWorldPoint(screenPos)
    self.obj = ABMgr:LoadRes("monsterobj","Monster",typeof(GameObject))
    self.obj.transform.position = worldPos
    self.obj.transform:SetParent(MainCamera)
    self.animator = self.obj.transform:GetComponent(typeof(Animator))
    self.state = {}
    self:InitData(self.id)
    self.luaObj = self.obj:AddComponent(typeof(LuaMonoObj))
    self.spriteRenderer = self.obj.transform:GetComponent(typeof(SpriteRenderer))
    self.Awake()
    self.luaObj:AddOrRemoveListener(function() self:Update() end,E_LifeFun_Type.Update)
end
function MonsterControl:InitData(id)
    self.animator.runtimeAnimatorController = ABMgr:LoadRes("monsteranimator","Animator_"..id.."_Monster",typeof(RuntimeAnimatorController))
    self.state.atk = GameDataMgr.MonsterInfos[id].atk
    self.state.bld = GameDataMgr.MonsterInfos[id].bld
end
function MonsterControl:UpdateWeapon(weapon)
    for i = 1,2 do
        if self.weapon[i] == nil then
            self.weapon[i] = weapon
            break
        end
    end
end

function MonsterControl:UpdateState(obj)
    for k,v in pairs(obj) do
        self.state[k]  = self.state[k] + v
    end
end