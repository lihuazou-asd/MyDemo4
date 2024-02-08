--继承Object
RoleGrid = Object:subClass("RoleGrid")
--初始化成员
RoleGrid.obj = nil
RoleGrid.id = nil
RoleGrid.btn = nil
RoleGrid.roleIcon = nil


function RoleGrid:BtnClick()
    UIMgr:GetPanel("StartPanel"):ChangeData(self.id)
end


function RoleGrid:Init(obj,id,father)
    self.obj = obj
    self.obj.transform:SetParent(father,false)
    --寻找组件脚本
    self.btn = self.obj.transform:GetComponent(typeof(Button))
    self.roleIcon = self.obj.transform:GetComponent(typeof(Image))
    self.id = id

    self.roleIcon.sprite = ABMgr:LoadRes("roleicon","RoleIcon_"..id,typeof(Sprite))
    


    --添加监听
    self.btn.onClick:AddListener(function()
        self:BtnClick()
    end)

end