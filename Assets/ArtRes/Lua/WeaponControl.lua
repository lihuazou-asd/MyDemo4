WeaponControl = Object:subClass("WeaponControl")

WeaponControl.obj = nil
WeaponControl.spriteRenderer = nil
WeaponControl.state = {atk = nil,bld = nil,dod = nil,spd = nil,crt = nil,crd = nil,def = nil,name = nil}
WeaponControl.rotateSpeed = 1000
WeaponControl.animator = nil
WeaponControl.id = nil

function WeaponControl:Init(id,obj)
    self.id = id
    self.obj = obj
    self.spriteRenderer = obj.transform:GetComponent(typeof(SpriteRenderer))
    self.spriteRenderer.sprite = ABMgr:LoadRes("weapon","Weapon_"..id,typeof(Sprite))

    self.animator = obj.transform:GetComponent(typeof(Animator))
    self.animator.runtimeAnimatorController = ABMgr:LoadRes("animatorbt","Animator_1_Weapon",typeof(RuntimeAnimatorController))

    
end
function WeaponControl:LookAt(nearMonsterControl,time)
    
    local angle =  math.deg(math.atan(nearMonsterControl.obj.transform.position.y-self.obj.transform.position.y,nearMonsterControl.obj.transform.position.x-self.obj.transform.position.x))
    local rotation = Quaternion.AngleAxis(angle, Vector3.forward)
    self.obj.transform.rotation = Quaternion.Slerp(self.obj.transform.rotation, rotation, time*self.rotateSpeed);
end

function WeaponControl:Atk()
    self.animator:SetTrigger("Atk")
    local tmpBullet = BulletControl:new()
    tmpBullet:Init(self.id,self.obj.transform.rotation,self.obj.transform.position)
end

