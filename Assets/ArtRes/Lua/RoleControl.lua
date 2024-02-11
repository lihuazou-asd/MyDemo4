RoleControl = Object:subClass("RoleControl")

RoleControl.id = nil
RoleControl.obj = nil
RoleControl.weaponTables = {}
RoleControl.luaObj = nil
RoleControl.animator = nil
RoleControl.spriteRenderer = nil

RoleControl.state = {atk = nil,bld = nil,dod = nil,spd = nil,crt = nil,crd = nil,def = nil,name = nil}


function RoleControl:Awake()

end
function RoleControl:Start()

end
function RoleControl:Update()
    if Input.GetKey("w") then
        self.obj.transform:Translate(Vector3.up*Time.deltaTime*5,Space.self);
    end
    if Input.GetKey("s") then
        self.obj.transform:Translate(-Vector3.up*Time.deltaTime*5,Space.self);
    end
    if Input.GetKey("a") then
        self.obj.transform:Translate(-Vector3.right*Time.deltaTime*5,Space.self);
        self.spriteRenderer.flipX = true
        self.weaponTables.obj1:flipX(true)
        self.weaponTables.obj2:flipX(true)
    end
    if Input.GetKey("d") then
        self.obj.transform:Translate(Vector3.right*Time.deltaTime*5,Space.self);
        self.spriteRenderer.flipX = false
        self.weaponTables.obj1:flipX(false)
        self.weaponTables.obj2:flipX(false)
    end

    if Input.GetKey("space") then
        print(1)
    end
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
    self.weaponTables = {}
    self.weaponTables.obj1 = WeaponControl:new()
    self.weaponTables.obj2 = WeaponControl:new()
    self.weaponTables.obj1:Init(id,self.obj.transform:Find("Weapon1").gameObject)
    self.weaponTables.obj2:Init(id,self.obj.transform:Find("Weapon2").gameObject)
    self.obj.transform:SetParent(MainCamera)
    self.animator = self.obj.transform:GetComponent(typeof(Animator))
    self.state = {}
    self:InitData(id)
    self.luaObj = self.obj:AddComponent(typeof(LuaMonoObj))
    self.spriteRenderer = self.obj.transform:GetComponent(typeof(SpriteRenderer))
    self.Awake()
    self.luaObj:AddOrRemoveListener(function() self:Update() end,E_LifeFun_Type.Update)
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