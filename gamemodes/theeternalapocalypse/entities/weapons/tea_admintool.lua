SWEP.Author = "Uklejamini" --Swep info and other stuff
SWEP.Contact = ""
SWEP.Purpose = "Admin Tool."
SWEP.Instructions = ""

if SERVER then
    SWEP.Weight = 1
    SWEP.AutoSwitchTo = false
    SWEP.AutoSwitchFrom = false
end

if CLIENT then
    SWEP.PrintName = "Admin Tool"
    SWEP.DrawCrosshair = true
    SWEP.DrawAmmo = false

    SWEP.ViewModelFOV = 60
    SWEP.ViewModelFlip = false
    SWEP.CSMuzzleFlashes = false

    SWEP.Slot = 1
    SWEP.SlotPos = 0
end

SWEP.AdminSpawnable = false
SWEP.Spawnable = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModel = ""
SWEP.WorldModel = ""

function SWEP:DrawHUD()
    draw.DrawText("ADMIN TOOL", "TargetIDSmall", ScrW()/2, ScrH()*0.2, color_white, TEXT_ALIGN_CENTER)
    draw.DrawText("Nothing to do with it yet, sorry.", "TargetIDSmall", ScrW()/2, ScrH()*0.2 + 20, color_white, TEXT_ALIGN_CENTER)
end

function SWEP:SetMode(mode)
    self:SetDTInt(0, mode)
end

function SWEP:GetMode()
    return self:GetDTInt(0)
end

function SWEP:SetSubMode(mode)
    self:SetDTInt(1, mode)
end

function SWEP:GetSubMode()
    return self:GetDTInt(1)
end

function SWEP:Initialize()
    self:SetHoldType(0)
end

function SWEP:PrimaryAttack()
    if self:GetMode() == ADMINTOOL_MODE_NONE then return end
end

function SWEP:SecondaryAttack()
    if CLIENT then
        gamemode.Call("OpenAdminToolSelectMode", self)
    end
end

function SWEP:Reload()
    if self.NextReload and self.NextReload > CurTime() then return end
    if CLIENT then
        gamemode.Call("OpenAdminToolMenu", self)
        self.NextReload = CurTime() + 0.6
    end
end

function SWEP:Holster()
    return true
end

local mat,matnum = Material("color")
if CLIENT then
    hook.Add("PostDrawOpaqueRenderables", "TEA.AdminTool.Render", function()
        local pl = LocalPlayer()
        local wep = pl.GetActiveWeapon and pl:GetActiveWeapon()
        if wep and wep:IsValid() and wep:GetClass() == "tea_admintool" then
            local pos = pl:GetEyeTrace().HitPos

            pos.x = math.Round(pos.x)
            pos.y = math.Round(pos.y)
            pos.z = math.Round(pos.z)

            render.SetMaterial(mat)
            render.DrawSphere(pos, 4, 8, 8, Color(255,0,0,200))
        end
    end)
end
