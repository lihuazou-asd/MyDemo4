Object:subClass("MainPanel")

MainPanel.obj = nil

function MainPanel:Init(obj)
    self.obj = obj
    self.obj.transform:SetParent(Canvas,false)
end