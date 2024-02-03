--继承Object
StartPanel = Object:subClass("StartPanel")
--初始化成员
StartPanel.obj = nil
StartPanel.btnStart = nil
StartPanel.btnExit = nil
StartPanel.svTransform = nil


function StartPanel:BtnStartClick()
    
end
function StartPanel:BtnExitClick()
    UIMgr:HidePanel("StartPanel")

end

function StartPanel:Init(obj)
    self.obj = obj
    self.obj.transform:SetParent(Canvas,false)
    --寻找组件脚本
    self.btnStart = self.obj.transform:Find("BtnStart"):GetComponent(typeof(Button))
    self.btnExit = self.obj.transform:Find("BtnExit"):GetComponent(typeof(Button))
    self.svTransform = self.obj.transform:Find("SV"):Find("Viewport"):Find("Content")
    --添加监听
    self.btnStart.onClick:AddListener(function()
        self:BtnStartClick()
    end)
    self.btnExit.onClick:AddListener(function()
        self:BtnExitClick()
    end)

end