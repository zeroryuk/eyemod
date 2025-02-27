TUNING.CUSTOM_EYE_FEED = GetModConfigData("custom_eye_feed")
TUNING.CUSTOM_EYE_UBREAKABLE = GetModConfigData("custom_eye_ubreakable")

TUNING.CUSTOM_EYE_M_DUR = GetModConfigData("custom_eye_m_dur")
TUNING.CUSTOM_EYE_S_DUR = GetModConfigData("custom_eye_s_dur")

TUNING.CUSTOM_EYE_M_ABS = GetModConfigData("custom_eye_m_abs")/100
TUNING.CUSTOM_EYE_S_ABS = GetModConfigData("custom_eye_s_abs")/100

TUNING.CUSTOM_EYE_S_DMG = GetModConfigData("custom_eye_s_dmg")
TUNING.CUSTOM_EYE_S_DMG_BROKEN = GetModConfigData("custom_eye_s_dmg_broken")

TUNING.CUSTOM_EYE_HEALTH_REPAIR_MULT = GetModConfigData("custom_eye_health_repair_mult") or 4
TUNING.CUSTOM_EYE_HUNGER_REPAIR_MULT = GetModConfigData("custom_eye_hunger_repair_mult") or 1.75

local function TakeDamage(self,damage_amount)
    if self.condition > damage_amount then
        self:SetCondition(self.condition - damage_amount)
        if self.ontakedamage ~= nil then
            self.ontakedamage(self.inst, damage_amount)
        end
        self.inst:PushEvent("armordamaged", damage_amount)
    else
        self:SetCondition(0)
    end
end
local function SetCondition(self,amount)
    if self.indestructible then
        return
    end
    self.condition = math.min(amount, self.maxcondition)
    self.inst:PushEvent("percentusedchange", { percent = self:GetPercent() })
    if self.condition == 0 then
        self.absorb_percent = 0
    else
        if self.oldabs then
            self.absorb_percent = self.oldabs
        else
            self.absorb_percent = 0.80
        end
    end
    if self.inst.components.weapon and self.absorb_percent ~= 0 then
        self.inst.components.weapon:SetDamage(TUNING.CUSTOM_EYE_S_DMG)
    elseif self.inst.components.weapon then
        self.inst.components.weapon:SetDamage(TUNING.CUSTOM_EYE_S_DMG_BROKEN)
    end
end


AddPrefabPostInit("eyemaskhat", function(inst)
	if not GLOBAL.TheWorld.ismastersim then return inst end
    if TUNING.CUSTOM_EYE_UBREAKABLE then
        inst.components.armor.TakeDamage = TakeDamage
        inst.components.armor.SetCondition = SetCondition
    end
    if TUNING.CUSTOM_EYE_M_DUR < 9999 then
        local amount = 0
        local absorb_percent = 0
        if TUNING.CUSTOM_EYE_M_DUR ~= 0 then
            amount = TUNING.CUSTOM_EYE_M_DUR
        else
            amount = TUNING.ARMOR_FOOTBALLHAT
        end
        if TUNING.CUSTOM_EYE_M_ABS ~= TUNING.ARMOR_FOOTBALLHAT_ABSORPTION then
            absorb_percent = TUNING.CUSTOM_EYE_M_ABS
        else
            absorb_percent = TUNING.ARMOR_FOOTBALLHAT_ABSORPTION
        end
        inst.components.armor.oldabs = absorb_percent
        inst.components.armor:InitCondition(amount, absorb_percent)
    else
        inst.components.armor:InitIndestructible(TUNING.CUSTOM_EYE_M_ABS)
    end
    if inst.components.eater then
        inst.components.eater:SetAbsorptionModifiers(TUNING.CUSTOM_EYE_HEALTH_REPAIR_MULT,TUNING.CUSTOM_EYE_HUNGER_REPAIR_MULT , 0)
    end
end)

AddPrefabPostInit("shieldofterror", function(inst)
	if not GLOBAL.TheWorld.ismastersim then return inst end
    if TUNING.CUSTOM_EYE_UBREAKABLE then
        inst.components.armor.TakeDamage = TakeDamage
        inst.components.armor.SetCondition = SetCondition
    end
    if TUNING.CUSTOM_EYE_S_DMG ~= TUNING.SHIELDOFTERROR_DAMAGE then
        inst.components.weapon:SetDamage(TUNING.CUSTOM_EYE_S_DMG)
    end
    if TUNING.CUSTOM_EYE_S_DUR < 9999 then
        local amount = 0
        local absorb_percent = 0
        if TUNING.CUSTOM_EYE_S_DUR ~= 0 then
            amount = TUNING.CUSTOM_EYE_S_DUR
        else
            amount = TUNING.SHIELDOFTERROR_ARMOR
        end
        if TUNING.CUSTOM_EYE_S_ABS ~= TUNING.SHIELDOFTERROR_ABSORPTION then
            absorb_percent = TUNING.CUSTOM_EYE_S_ABS
        else
            absorb_percent = TUNING.SHIELDOFTERROR_ABSORPTION
        end
        inst.components.armor.oldabs = absorb_percent
        inst.components.armor:InitCondition(amount, absorb_percent)
    else
        inst.components.armor:InitIndestructible(TUNING.CUSTOM_EYE_S_ABS)
    end
    if inst.components.eater then
        inst.components.eater:SetAbsorptionModifiers(TUNING.CUSTOM_EYE_HEALTH_REPAIR_MULT,TUNING.CUSTOM_EYE_HUNGER_REPAIR_MULT , 0)
    end
end)

if TUNING.CUSTOM_EYE_FEED then
    local function FeedAnim(self)
        local old_feed = self.actionhandlers[GLOBAL.ACTIONS.FEED].deststate
        self.actionhandlers[GLOBAL.ACTIONS.FEED].deststate = function(inst,action,...)
            if action.target and (action.target.prefab == "shieldofterror" or action.target.prefab == "eyemaskhat") then
                return "doshortaction"
            else
                return old_feed(inst,action,...)
            end
        end
    end
    
    AddStategraphPostInit("wilson", FeedAnim)
    AddStategraphPostInit("wilson_client", FeedAnim)
end

