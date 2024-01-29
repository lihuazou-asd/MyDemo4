Object:subClass("UIMgr")
UIMgr = _G["UIMgr"]
UIMgr.panelDic = {}


function UIMgr:ShowPanel(panelName)
    if self.panelDic[panelName]~=nil then
        return
    end
    local panelObj = ABMgr:LoadRes("uiprefab",panelName,typeof(GameObject))
    local panel = _G[panelName]:new()
    self.panelDic[panelName] = panel
    panel:Init(panelObj)
end

function UIMgr:HidePanel(panelName)
    if self.panelDic[panelName]==nil then
        return
    end
    GameObject.Destroy(self.panelDic[panelName].obj)
    self.panelDic[panelName] = nil
end