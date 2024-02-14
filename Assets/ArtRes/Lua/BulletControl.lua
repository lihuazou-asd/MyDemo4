BulletControl = Object:subClass("BulletControl")


function BulletControl:Awake()

end
function BulletControl:Start()

end
function BulletControl:Update()
    
end
function BulletControl:FixedUpdate()

end
function BulletControl:LateUpdate()
    self.obj.transform:Translate(self.obj.transform.right*Time.deltaTime*self.Speed,Space.self)
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
BulletControl.Speed = 5
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
    self.luaObj:AddOrRemoveListener(function() self:LateUpdate() end,E_LifeFun_Type.LateUpdate)
    self.luaObj:AddOrRemoveListener(function() self:LateUpdate() end,E_LifeFun_Type.LateUpdate)
    --self.luaObj:AddOrRemoveListener(function() self:OnTriggerEnter2D() end,E_LifeFun_Type.OnTriggerEnter2D)
end

