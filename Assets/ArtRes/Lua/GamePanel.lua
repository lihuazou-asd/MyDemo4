--继承Object
GamePanel = Object:subClass("GamePanel")
--初始化成员
GamePanel.obj = nil
GamePanel.txtTime = nil
GamePanel.txtBld = nil
GamePanel.txtMaxBld = nil
GamePanel.bldSlider = nil


function GamePanel:BtnStartClick()
    UIMgr:ShowPanel("StartPanel")

end
function GamePanel:BtnSetClick()
    UIMgr:ShowPanel("SetPanel")

end

function GamePanel:Init(obj)
    self.obj = obj
    self.obj.transform:SetParent(Canvas,false)
    --寻找组件脚本
    self.txtTime = self.obj.transform:Find("TxtTime"):GetComponent(typeof(Text))
    self.txtBld = self.obj.transform:Find("TxtBld"):GetComponent(typeof(Text))
    self.txtMaxBld = self.obj.transform:Find("TxtMaxBld"):GetComponent(typeof(Text))
    self.bldSlider = self.obj.transform:Find("Slider"):GetComponent(typeof(Slider))

    self.txtTime.text = GameLevelMgrInstance.levelInfo[GameLevelMgrInstance.nowLevel].time
    self.txtBld.text = GameLevelMgrInstance.roleControl.state.bld
    self.txtMaxBld.text = GameLevelMgrInstance.roleControl.state.bld
    
end

function GamePanel:ChangeValue(nowBld)
    self.txtBld.text = nowBld
    self.bldSlider.value = nowBld/tonumber(self.txtMaxBld.text)
end

function GamePanel:UpdateTime()
    self.txtTime.text = math.ceil(GameLevelMgrInstance.levelInfo[GameLevelMgr.nowLevel].time - GameLevelMgrInstance.Time)
end