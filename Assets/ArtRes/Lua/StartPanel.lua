--继承Object
StartPanel = Object:subClass("StartPanel")
--初始化成员
StartPanel.obj = nil
StartPanel.btnStart = nil
StartPanel.btnExit = nil
StartPanel.svTransform = nil

StartPanel.textName = nil
StartPanel.textBld = nil
StartPanel.textDod = nil
StartPanel.textSpd = nil
StartPanel.textCrt = nil
StartPanel.textCrd = nil
StartPanel.textAtk = nil
StartPanel.textDef = nil


function StartPanel:BtnStartClick()
    
end
function StartPanel:BtnExitClick()
    UIMgr:HidePanel("StartPanel")

end
function StartPanel:ChangeData(i)
    self.textAtk.text = GameDataMgr.PlayerInfos[i].atk
    self.textBld.text = GameDataMgr.PlayerInfos[i].bld
    self.textDod.text = GameDataMgr.PlayerInfos[i].dod
    self.textSpd.text = GameDataMgr.PlayerInfos[i].spd
    self.textCrt.text = GameDataMgr.PlayerInfos[i].crt
    self.textCrd.text = GameDataMgr.PlayerInfos[i].crd
    self.textDef.text = GameDataMgr.PlayerInfos[i].def
    self.textName.text = GameDataMgr.PlayerInfos[i].name

end

function StartPanel:Init(obj)
    self.obj = obj
    self.obj.transform:SetParent(Canvas,false)
    --寻找组件脚本
    self.btnStart = self.obj.transform:Find("BtnStart"):GetComponent(typeof(Button))
    self.btnExit = self.obj.transform:Find("BtnExit"):GetComponent(typeof(Button))
    self.svTransform = self.obj.transform:Find("SV"):Find("Viewport"):Find("Content")

    self.textAtk = self.obj.transform:Find("textAtk"):GetComponent(typeof(Text))
    self.textBld = self.obj.transform:Find("textBld"):GetComponent(typeof(Text))
    self.textDod = self.obj.transform:Find("textDod"):GetComponent(typeof(Text))
    self.textSpd = self.obj.transform:Find("textSpd"):GetComponent(typeof(Text))
    self.textCrt = self.obj.transform:Find("textCrt"):GetComponent(typeof(Text))
    self.textCrd = self.obj.transform:Find("textCrd"):GetComponent(typeof(Text))
    self.textDef = self.obj.transform:Find("textDef"):GetComponent(typeof(Text))
    self.textName = self.obj.transform:Find("textName"):GetComponent(typeof(Text))

    self:ChangeData(1)
    --添加监听
    self.btnStart.onClick:AddListener(function()
        self:BtnStartClick()
    end)
    self.btnExit.onClick:AddListener(function()
        self:BtnExitClick()
    end)

end