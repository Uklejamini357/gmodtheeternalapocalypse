SWEP.Author = "Uklejamini" --Swep info and other stuff
SWEP.Contact = ""
SWEP.Purpose = "Admin Tool"
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

SWEP.ViewModel = "models/weapons/v_physcannon.mdl"
SWEP.WorldModel = "models/weapons/w_physics.mdl"

function SWEP:DrawHUD()
end

function SWEP:SetupDataTables()
end

function SWEP:Reload()
end

function SWEP:GetSelected()
end

function SWEP:IsSelectedStructure()
end

function SWEP:GetSelectedStructureModel()
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
end

function SWEP:OnRemove()
end

function SWEP:Think()
end
