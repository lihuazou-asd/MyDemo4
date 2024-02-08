--继承Object
Object:subClass("UIMgr")
--常用名声明
UIMgr = _G["UIMgr"]
--面板字典
UIMgr.panelDic = {}


function UIMgr:ShowPanel(panelName)
    --如果面板存在则直接返回
    if self.panelDic[panelName]~=nil then
        return self.panelDic[panelName]
    end
    --从AB包内加载对应的面板并实例化出来
    local panelObj = ABMgr:LoadRes("uiprefab",panelName,typeof(GameObject))
    --创建实例对象
    local panel = _G[panelName]:new()
    --添加进字典
    self.panelDic[panelName] = panel
    --调用面板实例的初始化函数
    panel:Init(panelObj)
end

function UIMgr:HidePanel(panelName)
    --如果面板未显示则直接返回
    if self.panelDic[panelName]==nil then
        return
    end
    --销毁面板实例
    GameObject.Destroy(self.panelDic[panelName].obj)
    --设置为空
    self.panelDic[panelName] = nil
end
function UIMgr:GetPanel(panelName)
    if self.panelDic[panelName]~=nil then
        return self.panelDic[panelName]
    end
end