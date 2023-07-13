local playerMeta = FindMetaTable("Player")

function playerMeta:SaveWeapon(weapon, weaponItem)
    local character = self:GetCharacter()

    local wepItem

    if weaponItem then
        wepItem = weaponItem
        wepItem:OnSave()
    else
        local inventory = character:GetInventory()
        local items = inventory:GetItems()
        
        wepItem = self:FindWeaponItem(weapon, items)
    end

    character:SetData("currentWeapon", {weapon, wepItem})
end

function playerMeta:FindWeaponItem(weapon, items)
    for index, item in pairs(items) do
        if IsValid(weapon) and item:GetData("equip", false) and item.weapon == weapon:GetClass() then
            print("weapon item equipped: "..tostring(item))
            return item
        end
    end
    print("no weapon item found")
    return nil
end

function playerMeta:FindSmallestAmmoFor(weapon, items)
    local source

    for index, item in pairs(items) do
    end

    return source
end

function playerMeta:FindRefiller(weapon, items)
end