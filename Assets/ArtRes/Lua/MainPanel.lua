--继承Object
MainPanel = Object:subClass("MainPanel")
--初始化成员
MainPanel.obj = nil
MainPanel.btnStart = nil
MainPanel.btnSet = nil
MainPanel.btnHistory = nil
MainPanel.btnExit = nil


function MainPanel:BtnStartClick()
    UIMgr:ShowPanel("StartPanel")

end
function MainPanel:BtnSetClick()
    UIMgr:ShowPanel("SetPanel")

end

function MainPanel:Init(obj)
    self.obj = obj
    self.obj.transform:SetParent(Canvas,false)
    --寻找组件脚本
    self.btnStart = self.obj.transform:Find("BtnStart"):GetComponent(typeof(Button))
    self.btnSet = self.obj.transform:Find("BtnSet"):GetComponent(typeof(Button))
    self.btnHistory = self.obj.transform:Find("BtnHistory"):GetComponent(typeof(Button))
    self.btnExit = self.obj.transform:Find("BtnExit"):GetComponent(typeof(Button))
    --添加监听
    self.btnStart.onClick:AddListener(function()
        self:BtnStartClick()
    end)
    self.btnSet.onClick:AddListener(function()
        self:BtnSetClick()
    end)
    self.btnHistory.onClick:AddListener(function()

    end)
    self.btnExit.onClick:AddListener(function()

    end)

end