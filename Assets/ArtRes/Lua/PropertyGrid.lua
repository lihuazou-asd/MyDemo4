--继承Object
PropertyGrid = Object:subClass("PropertyGrid")

PropertyGrid.obj = nil
PropertyGrid.id = nil
PropertyGrid.txtName = nil
PropertyGrid.txtNum = nil

function PropertyGrid:Init(id,transform,key,value)
    self.id = id
    self.obj = ABMgr:LoadRes("uiprefab","PropertyGrid",typeof(GameObject))
    self.obj.transform:SetParent(transform,false)
    self.txtName = self.obj.transform:Find("TxtProperty"):GetComponent(typeof(Text))
    self.txtNum = self.obj.transform:Find("TxtNum"):GetComponent(typeof(Text))

    self.txtName.text = ObjPropertyTranslate[key]
    self.txtNum.text = value
end

