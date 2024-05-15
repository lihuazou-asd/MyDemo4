--继承Object
DetailPanel = Object:subClass("DetailPanel")

DetailPanel.obj = nil
DetailPanel.id = nil
DetailPanel.svDetailPanelRectTransform = nil
DetailPanel.svViewPortRectTransform = nil
DetailPanel.svContentTransform = nil
DetailPanel.state = nil

function DetailPanel:Init(id,state,position)
    self.id = id
    self.state = state
    
    self.obj = ABMgr:LoadRes("uiprefab","DetailPanel",typeof(GameObject))
    self.obj.transform:SetParent(Canvas,false)

    
    self.svDetailPanelRectTransform = self.obj.transform:GetComponent(typeof(RectTransform))
    self.svViewPortRectTransform = self.obj.transform:Find("Viewport"):GetComponent(typeof(RectTransform))
    self.svContentTransform = self.obj.transform:Find("Viewport"):Find("Content")
    self.svDetailPanelRectTransform.anchorMin = Vector2(0,0)
    self.svDetailPanelRectTransform.anchorMax = Vector2(0,0)
    self.svDetailPanelRectTransform.anchoredPosition = position
    self.svDetailPanelRectTransform.pivot= Vector2(0,1)
    self:ShowDetail(id,self.svContentTransform)
    


end

function DetailPanel:ShowDetail(id,transform)
    for k,v in pairs(self.state) do
        if k ~= "id" then
            local tmpPropertyGrid = PropertyGrid:new()
            tmpPropertyGrid:Init(id,transform,k,v)
            local tmpDetailPanelV2 = Vector2(self.svDetailPanelRectTransform.sizeDelta.x,self.svDetailPanelRectTransform.sizeDelta.y + 100)
            self.svDetailPanelRectTransform.sizeDelta = tmpDetailPanelV2
            local tmpViewPortV2 = Vector2(self.svViewPortRectTransform.sizeDelta.x,self.svViewPortRectTransform.sizeDelta.y + 100)
            self.svViewPortRectTransform.sizeDelta = tmpViewPortV2
        end
    end
    local tmpDetailPanelV2 = Vector2(self.svDetailPanelRectTransform.sizeDelta.x,self.svDetailPanelRectTransform.sizeDelta.y - 100)
    self.svDetailPanelRectTransform.sizeDelta = tmpDetailPanelV2
    local tmpViewPortV2 = Vector2(self.svViewPortRectTransform.sizeDelta.x,self.svViewPortRectTransform.sizeDelta.y - 100)
    self.svViewPortRectTransform.sizeDelta = tmpViewPortV2
end

