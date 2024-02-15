--继承Object
ChoosePanel = Object:subClass("ChoosePanel")
--初始化成员
ChoosePanel.obj = nil
ChoosePanel.btnStart = nil
ChoosePanel.svBagTransform = nil
ChoosePanel.svSelectTransform = nil

ChoosePanel.textName = nil
ChoosePanel.textBld = nil
ChoosePanel.textDod = nil
ChoosePanel.textSpd = nil
ChoosePanel.textCrt = nil
ChoosePanel.textCrd = nil
ChoosePanel.textAtk = nil
ChoosePanel.textDef = nil


function ChoosePanel:BtnStartClick()
    UIMgr:HidePanel("ChoosePanel")
    GameLevelMgrInstance:NextLevel()
end

function ChoosePanel:Init(obj)
    self.obj = obj
    self.obj.transform:SetParent(Canvas,false)
    --寻找组件脚本
    self.btnStart = self.obj.transform:Find("BtnStart"):GetComponent(typeof(Button))
    self.svBagTransform = self.obj.transform:Find("SVBag"):Find("Viewport"):Find("Content")
    self.svSelectTransform = self.obj.transform:Find("SVSelect"):Find("Viewport"):Find("Content")

    self.textAtk = self.obj.transform:Find("textAtk"):GetComponent(typeof(Text))
    self.textBld = self.obj.transform:Find("textBld"):GetComponent(typeof(Text))
    self.textDod = self.obj.transform:Find("textDod"):GetComponent(typeof(Text))
    self.textSpd = self.obj.transform:Find("textSpd"):GetComponent(typeof(Text))
    self.textCrt = self.obj.transform:Find("textCrt"):GetComponent(typeof(Text))
    self.textCrd = self.obj.transform:Find("textCrd"):GetComponent(typeof(Text))
    self.textDef = self.obj.transform:Find("textDef"):GetComponent(typeof(Text))
    self.textName = self.obj.transform:Find("textName"):GetComponent(typeof(Text))

    self.textAtk.text = GameLevelMgrInstance.roleControl.state.atk
    self.textBld.text = GameLevelMgrInstance.roleControl.state.bld
    self.textDod.text = GameLevelMgrInstance.roleControl.state.dod
    self.textSpd.text = GameLevelMgrInstance.roleControl.state.spd
    self.textCrt.text = GameLevelMgrInstance.roleControl.state.crt
    self.textCrd.text = GameLevelMgrInstance.roleControl.state.crd
    self.textDef.text = GameLevelMgrInstance.roleControl.state.def
    self.textName.text = GameLevelMgrInstance.roleControl.state.name
 
    --添加监听
    self.btnStart.onClick:AddListener(function()
        self:BtnStartClick()
    end)

end

function ChoosePanel:GenerateSelectGrid()


end

function ChoosePanel:GenerateBagGrid()


end

function ChoosePanel:UpdateState()
    self.textAtk.text = GameLevelMgrInstance.roleControl.state.atk
    self.textBld.text = GameLevelMgrInstance.roleControl.state.bld
    self.textDod.text = GameLevelMgrInstance.roleControl.state.dod
    self.textSpd.text = GameLevelMgrInstance.roleControl.state.spd
    self.textCrt.text = GameLevelMgrInstance.roleControl.state.crt
    self.textCrd.text = GameLevelMgrInstance.roleControl.state.crd
    self.textDef.text = GameLevelMgrInstance.roleControl.state.def
    self.textName.text = GameLevelMgrInstance.roleControl.state.name
end