-- 事件中心类
Object:subClass("EventCenter")
eventCenter = _G["EventCenter"]:new()
eventCenter.events = {}
-- 添加一个监听函数，eventName是事件名，func是函数或对象，method是方法名（可选）
function EventCenter:addListener(eventName, func, method)
    if self.events[eventName] == nil then
        self.events[eventName] = {} -- 如果事件不存在，创建一个空表
    end
    local listener = {func = func, method = method} -- 创建一个监听器对象
    table.insert(self.events[eventName], listener) -- 将监听器对象插入到事件表中
end

-- 移除一个监听函数，eventName是事件名，func是函数或对象，method是方法名（可选）
function EventCenter:removeListener(eventName, func, method)
    if self.events[eventName] then
        for i,v in pairs(self.events[eventName]) do
            if self.events[eventName][i].func == func and self.events[eventName][i].method == method then
                self.events[eventName][i] = nil
                break
            end
        end
    end
end

-- 触发一个事件，eventName是事件名，...是任意数量的参数
function EventCenter:triggerEvent(eventName,...)
    if self.events[eventName] then
        for _, listener in pairs(self.events[eventName]) do
            if listener.func ~= nil then
                if listener.method == nil then
                    listener.func(...) -- 如果监听器对象没有方法名，直接调用函数
                else
                    listener.method(listener.func,...)
                end
            end
        end
    end
end