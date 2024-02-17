--执行初始化的脚本
require("InitClass")
GameDataMgr:Init()
UIMgr:ShowPanel("MainPanel")

-- 定义一个静态函数
local function printHello()
    print("Hello")
end

-- 定义一个类
Person = Object:subClass("Person")


-- 创建一个新的Person对象
function Person:new(name)
    local obj = {}
    setmetatable(obj, Person)
    obj.name = name
    return obj
end

-- 定义一个实例方法
function Person:sayHi()
    print("Hi, I am " .. self.name)
end


-- 创建两个Person对象
local alice = Person:new()
alice.name = "Alice"
local bob = Person:new()
bob.name = "bob"

-- 添加监听函数
eventCenter:addListener("greet", printHello) -- 添加一个静态函数
eventCenter:addListener("greet", alice,Person.sayHi) -- 添加一个实例方法
eventCenter:addListener("greet", bob,Person.sayHi) -- 添加一个实例方法

-- 触发事件
eventCenter:triggerEvent("greet") -- 触发greet事件，输出：
-- Hello
-- Hi, I am Alice
-- Hi, I am Bob

-- 移除监听函数
eventCenter:removeListener("greet", printHello) -- 移除一个静态函数
eventCenter:removeListener("greet", bob,Person.sayHi) -- 移除一个实例方法

-- 触发事件
eventCenter:triggerEvent("greet") -- 触发greet事件，输出：
-- Hi, I am Alice