Object:subClass("PoolData")


PoolData.fatherObj = nil
PoolData.poolList = nil

function PoolData:Init(obj,poolObj)
    self.fatherObj = GameObject(obj.name)
    self.fatherObj.transform.parent = poolObj.transform
    self.poolList = {}
    self:PushObject(obj)
end

function PoolData:PushObject(gameObject)
    table.insert(self.poolList,gameObject)
    gameObject.transform.parent = self.fatherObj.transform
    gameObject:SetActive(false)
end

function PoolData:GetObject()
    local obj = nil
    for i = 1,#self.poolList do
        obj = self.poolList[i]
        table.remove(self.poolList,i)
        break
    end
    obj:SetActive(true)
    obj.transform.parent = nil
    return obj
end