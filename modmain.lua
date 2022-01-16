TUNING.CUSTOM_EYE_UBREAKABLE = GetModConfigData("custom_eye_ubreakable")

TUNING.CUSTOM_EYE_M_DUR = GetModConfigData("custom_eye_m_dur")
TUNING.CUSTOM_EYE_S_DUR = GetModConfigData("custom_eye_s_dur")

TUNING.CUSTOM_EYE_M_ABS = GetModConfigData("custom_eye_m_abs")/100
TUNING.CUSTOM_EYE_S_ABS = GetModConfigData("custom_eye_s_abs")/100

TUNING.CUSTOM_EYE_S_DMG = GetModConfigData("custom_eye_s_dmg")


TUNING.CUSTOM_EYE_M_DUR = 1000
TUNING.CUSTOM_EYE_S_DUR = 1000


local function Setcondition(self,amount)
    if self.indestructible then
		return
	end

    self.condition = math.min(amount, self.maxcondition)
    self.inst:PushEvent("percentusedchange", { percent = self:GetPercent() })
end


AddPrefabPostInit("eyemaskhat", function(inst)

	if not GLOBAL.TheWorld.ismastersim then return inst end
        local _setcondition = inst.components.armor.Setcondition
        if TUNING.CUSTOM_EYE_UBREAKABLE then
            inst.components.armor.Setcondition = Setcondition
        else
            inst.components.armor.Setcondition = _setcondition
        end
        if TUNING.CUSTOM_EYE_M_DUR < 9999 then
            local _initcondition = inst.components.armor.InitCondition
            inst.components.armor.InitCondition = function (self,amount, absorb_percent)
                if TUNING.CUSTOM_EYE_M_DUR ~= 0 then
                    amount = TUNING.CUSTOM_EYE_M_DUR
                end
                absorb_percent = TUNING.CUSTOM_EYE_M_ABS
                _initcondition(amount, absorb_percent)
            end
        else
            inst.components.armor:InitIndestructible(TUNING.CUSTOM_EYE_M_ABS)
        end
end)

AddPrefabPostInit("shieldofterror", function(inst)

	if not GLOBAL.TheWorld.ismastersim then return inst end
        local _setcondition = inst.components.armor.Setcondition
        if TUNING.CUSTOM_EYE_UBREAKABLE then
            inst.components.armor.Setcondition = Setcondition
        else
            inst.components.armor.Setcondition = _setcondition
        end
        if TUNING.CUSTOM_EYE_S_DMG ~= TUNING.SHIELDOFTERROR_DAMAGE then
            inst.components.weapon:SetDamage(TUNING.CUSTOM_EYE_S_DMG)
        end
        if TUNING.CUSTOM_EYE_S_DUR < 9999 then
            local _initcondition = inst.components.armor.InitCondition
            inst.components.armor.InitCondition = function (self,amount, absorb_percent)
                if TUNING.CUSTOM_EYE_S_DUR ~= 0 then
                    amount = TUNING.CUSTOM_EYE_S_DUR
                end
                absorb_percent = TUNING.CUSTOM_EYE_S_ABS
                _initcondition(amount, absorb_percent)
            end
        else
            inst.components.armor:InitIndestructible(TUNING.CUSTOM_EYE_S_ABS)
        end
end)
