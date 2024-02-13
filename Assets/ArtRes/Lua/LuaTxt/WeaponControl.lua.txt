WeaponControl = Object:subClass("WeaponControl")

WeaponControl.obj = nil
WeaponControl.luaObj = nil
WeaponControl.spriteRenderer = nil
WeaponControl.state = {atk = nil,bld = nil,dod = nil,spd = nil,crt = nil,crd = nil,def = nil,name = nil}
WeaponControl.rotateSpeed = 1000


function WeaponControl:Init(id,obj)
    self.obj = obj
    self.spriteRenderer = obj.transform:GetComponent(typeof(SpriteRenderer))
    self.spriteRenderer.sprite = ABMgr:LoadRes("weapon","Weapon_"..id,typeof(Sprite))


    self.luaObj = self.obj:AddComponent(typeof(LuaMonoObj))
    self.luaObj:AddOrRemoveListener(self.Update,E_LifeFun_Type.Update)
end
function WeaponControl:LookAt(nearMonsterControl,time)
    
    local angle =  math.deg(math.atan(nearMonsterControl.DistanceWithRoleXY.y,nearMonsterControl.DistanceWithRoleXY.x))

    local rotation = Quaternion.AngleAxis(angle, Vector3.forward)
    self.obj.transform.rotation = Quaternion.Slerp(self.obj.transform.rotation, rotation, time*self.rotateSpeed);
end

