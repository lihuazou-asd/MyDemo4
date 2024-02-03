--继承Object
SetPanel = Object:subClass("SetPanel")
--声明成员
SetPanel.obj = nil
SetPanel.sldBgm = nil
SetPanel.sldBtm = nil
SetPanel.sldBgmText = nil
SetPanel.sldBtmText = nil
SetPanel.btnExit = nil


function SetPanel:BtnExitClick()
    UIMgr:HidePanel("SetPanel")

end


function SetPanel:Init(obj)
    --初始化obj并设置父对象
    self.obj = obj
    self.obj.transform:SetParent(Canvas,false)
    --初始化其他成员变量
    self.btnExit = self.obj.transform:Find("BtnExit"):GetComponent(typeof(Button))
    self.sldBgmText = self.obj.transform:Find("SldBgmNum"):GetComponent(typeof(Text))
    self.sldBtmText = self.obj.transform:Find("SldBtmNum"):GetComponent(typeof(Text))
    self.sldBgm = self.obj.transform:Find("SldBgm"):GetComponent(typeof(Slider))
    self.sldBtm = self.obj.transform:Find("SldBtm"):GetComponent(typeof(Slider))
    


    --添加监听
    self.sldBgm.onValueChanged:AddListener(function(i)
        self.sldBgmText.text = i
    end)
    self.sldBtm.onValueChanged:AddListener(function(i)
        self.sldBtmText.text = i
    end)
    self.btnExit.onClick:AddListener(function()
        self:BtnExitClick()
    end)

end