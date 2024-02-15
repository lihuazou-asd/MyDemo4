WeaponControl = Object:subClass("WeaponControl")

WeaponControl.fatherObj = nil
WeaponControl.sonObj = nil
WeaponControl.spriteRenderer = nil
WeaponControl.state = {atk = nil,bld = nil,dod = nil,spd = nil,crt = nil,crd = nil,def = nil,name = nil}
WeaponControl.rotateSpeed = 1000
WeaponControl.animator = nil
WeaponControl.id = nil

function WeaponControl:Init(id,fatherObj,weaponId)
    self.id = id
    self.fatherObj = fatherObj
    self.sonObj = fatherObj.transform:Find("Weapon"..weaponId).gameObject
    self.spriteRenderer = self.sonObj.transform:GetComponent(typeof(SpriteRenderer))
    self.spriteRenderer.sprite = ABMgr:LoadRes("weapon","Weapon_"..id,typeof(Sprite))

    self.animator = self.sonObj.transform:GetComponent(typeof(Animator))
    self.animator.runtimeAnimatorController = ABMgr:LoadRes("animatorbt","Animator_"..id.."_Weapon",typeof(RuntimeAnimatorController))

    
end
function WeaponControl:LookAt(nearMonsterControl,time)
    
    local angle =  math.deg(math.atan(nearMonsterControl.obj.transform.position.y-self.fatherObj.transform.position.y,nearMonsterControl.obj.transform.position.x-self.fatherObj.transform.position.x))
    local rotation = Quaternion.AngleAxis(angle, Vector3.forward)
    self.fatherObj.transform.rotation = Quaternion.Slerp(self.fatherObj.transform.rotation, rotation, time*self.rotateSpeed);
end

function WeaponControl:Atk()
    self.animator:SetTrigger("Atk")
    local tmpBullet = BulletControl:new()
    tmpBullet:Init(self.id,self.fatherObj.transform.rotation,self.fatherObj.transform.position)
end

