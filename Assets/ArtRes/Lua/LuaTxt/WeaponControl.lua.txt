WeaponControl = Object:subClass("WeaponControl")

WeaponControl.obj = nil
WeaponControl.luaObj = nil
WeaponControl.spriteRenderer = nil
WeaponControl.state = {atk = nil,bld = nil,dod = nil,spd = nil,crt = nil,crd = nil,def = nil,name = nil}



function WeaponControl:Init(id,obj)
    self.obj = obj
    self.spriteRenderer = obj.transform:GetComponent(typeof(SpriteRenderer))
    self.spriteRenderer.sprite = ABMgr:LoadRes("weapon","Weapon_"..id,typeof(Sprite))


    self.luaObj = self.obj:AddComponent(typeof(LuaMonoObj))
    self.luaObj:AddOrRemoveListener(self.Update,E_LifeFun_Type.Update)
end
function WeaponControl:flipX(isFilp)
    self.spriteRenderer.flipX = isFilp
end

