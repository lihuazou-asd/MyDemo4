RoleControl = Object:subClass("RoleControl")

RoleControl.id = nil
RoleControl.obj = nil
RoleControl.weaponTables = {}
RoleControl.luaObj = nil
RoleControl.animator = nil
RoleControl.spriteRenderer = nil
RoleControl.rigid = nil

RoleControl.nearMonsterControl = nil

RoleControl.state = {atk = nil,bld = nil,dod = nil,spd = nil,crt = nil,crd = nil,def = nil,name = nil}


function RoleControl:Awake()

end
function RoleControl:Start()

end
function RoleControl:Update()
    if self.nearMonsterControl ~= nil then
        self.weaponTables.obj1:LookAt(self.nearMonsterControl,Time.deltaTime)
        self.weaponTables.obj2:LookAt(self.nearMonsterControl,Time.deltaTime)
    end

    if Input.GetKey(KeyCode.W) then
        self.rigid.velocity = Vector2(self.rigid.velocity.x, 5);
    end
    if Input.GetKey(KeyCode.S) then
        self.rigid.velocity = Vector2(self.rigid.velocity.x, -5);
    end
    if Input.GetKey(KeyCode.A) then
        self.rigid.velocity = Vector2(-5,self.rigid.velocity.y);
        self.spriteRenderer.flipX = true
    end
    if Input.GetKey(KeyCode.D) then
        self.rigid.velocity = Vector2(5,self.rigid.velocity.y);
        self.spriteRenderer.flipX = false
    end
    if Input.GetKeyUp(KeyCode.W) then
        self.rigid.velocity = Vector2(0,0);
    end
    if Input.GetKeyUp(KeyCode.S) then
        self.rigid.velocity = Vector2(0,0);
    end
    if Input.GetKeyUp(KeyCode.A) then
        self.rigid.velocity = Vector2(0,0);
    end
    if Input.GetKeyUp(KeyCode.D) then
        self.rigid.velocity = Vector2(0,0);
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
    self.nearMonsterTransform = nil;
    self.id = id
    self.obj = ABMgr:LoadRes("roleobj","PlayRole",typeof(GameObject))
    self.weaponTables = {}
    self.weaponTables.obj1 = WeaponControl:new()
    self.weaponTables.obj2 = WeaponControl:new()
    self.weaponTables.obj1:Init(id,self.obj.transform:Find("Weapon1").gameObject)
    self.weaponTables.obj2:Init(id,self.obj.transform:Find("Weapon2").gameObject)
    self.obj.transform:SetParent(MainCamera,false)
    self.animator = self.obj.transform:GetComponent(typeof(Animator))
    self.rigid = self.obj.transform:GetComponent(typeof(Rigidbody2D))
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