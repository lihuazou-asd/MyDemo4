RoleControl = Object:subClass("RoleControl")

RoleControl.id = nil
RoleControl.obj = nil
RoleControl.weapon = {}
RoleControl.luaObj = nil
RoleControl.animator = nil

RoleControl.state = {atk = nil,bld = nil,dod = nil,spd = nil,crt = nil,crd = nil,def = nil,name = nil}


function RoleControl:Awake()

end
function RoleControl:Start()

end
function RoleControl:Update()
    print(1)
end
function RoleControl:FixedUpdate()

end
function RoleControl:LateUpdate()

end
function RoleControl:OnEnable()

end
function RoleControl:OnDisable()

end
function RoleControl:OnDestroy()

end

function RoleControl:Init(id)
    self.id = id
    self.obj = ABMgr:LoadRes("roleobj","PlayRole",typeof(GameObject))
    self.obj.transform:SetParent(MainCamera)
    self.animator = self.obj.transform:GetComponent(typeof(Animator))
    self.state = {}
    --self.animator.runtimeAnimatorController = ABMgr:LoadRes("animatorbt","Animator_"..id.."_Bt",typeof(RuntimeAnimatorController))
    --self.state = GameDataMgr.PlayerInfos[id]
    self:InitData(id)
    self.luaObj = self.obj:AddComponent(typeof(LuaMonoObj))
    self.Awake()
    self.luaObj:AddOrRemoveListener(self.Update,E_LifeFun_Type.Update)
    
    

end
function RoleControl:InitData(id)
    self.animator.runtimeAnimatorController = ABMgr:LoadRes("animatorbt","Animator_"..id.."_Bt",typeof(RuntimeAnimatorController))
    self.state.atk = GameDataMgr.PlayerInfos[id].atk
    self.state.bld = GameDataMgr.PlayerInfos[id].bld
    self.state.dod = GameDataMgr.PlayerInfos[id].dod
    self.state.spd = GameDataMgr.PlayerInfos[id].spd
    self.state.crt = GameDataMgr.PlayerInfos[id].crt
    self.state.crd = GameDataMgr.PlayerInfos[id].crd
    self.state.def = GameDataMgr.PlayerInfos[id].def
    self.state.name = GameDataMgr.PlayerInfos[id].name
end
function RoleControl:UpdateWeapon(weapon)
    for i = 1,2 do
        if self.weapon[i] == nil then
            self.weapon[i] = weapon
            break
        end
    end
end

function RoleControl:UpdateState(obj)
    for k,v in pairs(obj) do
        self.state[k]  = self.state[k] + v
    end
    


end