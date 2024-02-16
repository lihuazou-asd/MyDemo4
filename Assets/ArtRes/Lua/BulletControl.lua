BulletControl = Object:subClass("BulletControl")


function BulletControl:Awake()

end
function BulletControl:Start()
    self.luaObj:StartCoroutine(util.cs_generator(function() self:DelayDestroy(5) end))
end
function BulletControl:Update()
    self.obj.transform:Translate(self.obj.transform.right*Time.deltaTime*self.Speed,Space.self)
end
function BulletControl:FixedUpdate()

end
function BulletControl:LateUpdate()
    
end
function BulletControl:OnEnable()

end
function BulletControl:OnDisable()

end
function BulletControl:OnDestroy()

end

function BulletControl:OnTriggerEnter2D()


end


BulletControl.obj = nil
BulletControl.renderer = nil
BulletControl.id = nil
BulletControl.Speed = 50
BulletControl.luaObj = nil

function BulletControl:Init(id,rotation,pos)
    self.obj = ABMgr:LoadRes("bullet","BulletObj",typeof(GameObject))
    self.renderer = self.obj.transform:Find("renderer"):GetComponent(typeof(SpriteRenderer))
    
    self.id = id
    self.obj.transform:SetParent(MainCamera)
    self.obj.transform.position = pos
    self.obj.transform.rotation = rotation

    self.renderer.sprite = ABMgr:LoadRes("bullet","bullet_"..id,typeof(Sprite))
    
    self.luaObj = self.obj:AddComponent(typeof(LuaMonoObj))
    self.Awake()
    self.luaObj:AddOrRemoveListener(function() self:Start() end,E_LifeFun_Type.Start)
    self.luaObj:AddOrRemoveListener(function() self:Update() end,E_LifeFun_Type.Update)

    
    
end

function BulletControl:DelayDestroy(time)
    coroutine.yield(WaitForSeconds(time))
    GameObject.Destroy(self.obj)
end

