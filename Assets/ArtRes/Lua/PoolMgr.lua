Object:subClass("PoolMgr")


PoolMgr.dicObj = nil
PoolMgr.poolObj = nil

function PoolMgr:Init()
    self.dicObj = {}
    self.poolObj = nil
end

function PoolMgr:PushObject(name,gameObject)
    if self.poolObj == nil then
        self.poolObj = GameObject("Pool")
    end
    if self.dicObj[name] == nil then
        self.dicObj[name] = _G["PoolData"]:new()
        self.dicObj[name]:Init(gameObject,self.poolObj)
    else
        self.dicObj[name]:PushObject(gameObject)
    end
end

function PoolMgr:GetObject(name,abName,resName,type)
    if self.dicObj[name] ~=nil and #self.dicObj[name].poolList >0 then
        return self.dicObj[name]:GetObject()
    else
        return ABMgr:LoadRes(abName,resName,type)
    end
end