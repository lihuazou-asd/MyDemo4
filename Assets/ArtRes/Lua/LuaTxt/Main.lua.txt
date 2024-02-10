--执行初始化的脚本
require("InitClass")
GameDataMgr:Init()
UIMgr:ShowPanel("MainPanel")

table1 = { data1 = 19,data2 = 32}

test = Json.encode(table1)

print(test)
