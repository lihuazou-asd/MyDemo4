--执行初始化的脚本
require("InitClass")
GameDataMgr:Init()
UIMgr:ShowPanel("MainPanel")


local tmpObj1 = GameObject("test")
local tmpObj2 = GameObject("test")
local tmpObj3 = GameObject("sss")
local tmpObj4 = GameObject("zzt")
local tmpObj5 = GameObject("tsst")
local tmpObj6 = GameObject("zzt")
local tmpObj7 = GameObject("test")

poolMgr:PushObject(tmpObj1.name,tmpObj1)
poolMgr:PushObject(tmpObj2.name,tmpObj2)
poolMgr:PushObject(tmpObj3.name,tmpObj3)
poolMgr:PushObject(tmpObj4.name,tmpObj4)
poolMgr:PushObject(tmpObj5.name,tmpObj5)
poolMgr:PushObject(tmpObj6.name,tmpObj6)
poolMgr:PushObject(tmpObj7.name,tmpObj7)

poolMgr:GetObject("zzt")

poolMgr:GetObject("test")

poolMgr:GetObject("test")