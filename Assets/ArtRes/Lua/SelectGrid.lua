--继承Object
SelectGrid = Object:subClass("SelectGrid")
--初始化成员
SelectGrid.obj = nil
SelectGrid.id = nil
SelectGrid.btn = nil
SelectGrid.roleIcon = nil
SelectGrid.txtNum = nil

SelectGrid.eventTrigger = nil
SelectGrid.myDetailPanel = nil

SelectGrid.state = nil



function SelectGrid:BtnClick()
    GameLevelMgrInstance:AddBagIcon(self.id)
    GameLevelMgrInstance.roleControl:UpdateState(self.state)
    UIMgr:GetPanel("ChoosePanel"):UpdateState()
end

function SelectGrid:OnPointerEnter()
    local entry = EventTrigger.Entry()
    entry.eventID = EventTriggerType.PointerEnter
    entry.callback:AddListener(function(data) self:OnPointerEnterEvent(data) end)
    self.eventTrigger.triggers:Add(entry)
end

function SelectGrid:OnPointerEnterEvent(data)
    print("鼠标进入")
    local tmpDetailPanel = DetailPanel:new()
    self.myDetailPanel = tmpDetailPanel
    UIMgr:GetPanel("ChoosePanel").nowDetailPanel = tmpDetailPanel
    tmpDetailPanel:Init(self.id,self.state,data.position)
end

function SelectGrid:OnPointerExit()
    local entry = EventTrigger.Entry()
    entry.eventID = EventTriggerType.PointerExit
    entry.callback:AddListener(function(data) self:OnPointerExitEvent(data) end)
    self.eventTrigger.triggers:Add(entry)
end

function SelectGrid:OnPointerExitEvent(data)
    GameObject.Destroy(self.myDetailPanel.obj)
    self.myDetailPanel = nil
end




function SelectGrid:Init(id,father,isSelectGrid)
    self.obj = ABMgr:LoadRes("uiprefab","SelectGrid",typeof(GameObject))
    self.obj.transform:SetParent(father,false)
    self.myDetailPanel = nil
    --寻找组件脚本
    self.btn = self.obj.transform:GetComponent(typeof(Button))
    self.eventTrigger = self.obj.transform:GetComponent(typeof(EventTrigger))
    self.roleIcon = self.obj.transform:Find("ImgIcon"):GetComponent(typeof(Image))
    self.id = id
    self.roleIcon.sprite = ABMgr:LoadRes("selecticon","SelectIconAtlas",typeof(SpriteAtlas)):GetSprite("SelectIcon_"..id)
    self.state = GameDataMgr.SelectObjInfos[id]
    

    if isSelectGrid then
        --添加监听
        self.btn.onClick:AddListener(function()
            self:BtnClick()
        end)
    else
        self.btn.transition = Transition.None
        self.txtNum = self.obj.transform:Find("TxtNum"):GetComponent(typeof(Text))
        self.txtNum.text = GameLevelMgrInstance.BagIcon[id].num
    end
    self:OnPointerEnter()
    self:OnPointerExit()
end

function SelectGrid:ChangeNum(num)
    self.txtNum.text = num
end