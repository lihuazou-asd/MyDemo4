--继承Object
SelectGrid = Object:subClass("RoleGrid")
--初始化成员
SelectGrid.obj = nil
SelectGrid.id = nil
SelectGrid.btn = nil
SelectGrid.roleIcon = nil
SelectGrid.txtNum = nil


function SelectGrid:BtnClick()
    UIMgr:GetPanel("StartPanel"):ChangeData(self.id)
end


function SelectGrid:Init(obj,id,father)
    self.obj = obj
    self.obj.transform:SetParent(father,false)
    --寻找组件脚本
    self.btn = self.obj.transform:GetComponent(typeof(Button))
    self.roleIcon = self.obj.transform:Find("ImgIcon"):GetComponent(typeof(Image))
    self.txtNum = self.obj.transform:Find("TxtNum"):GetComponent(typeof(Text))

    self.id = id

    self.roleIcon.sprite = ABMgr:LoadRes("selecticon","selecticon_"..id,typeof(Sprite))
    


    --添加监听
    self.btn.onClick:AddListener(function()
        self:BtnClick()
    end)
    

end