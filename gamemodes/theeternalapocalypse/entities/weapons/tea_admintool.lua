SWEP.Author = "Uklejamini" --Swep info and other stuff
SWEP.Contact = ""
SWEP.Purpose = "Admin Tool. It can do anything you need, or what you don't need."
SWEP.Instructions = "LMB to spawn in something specific, or to perform certain action.\nRMB to open configuration menu.\nR to open admintool menu."

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

local name = {
    "Spawner",
    "Delete",
    "Delete [UNSAFE]"
}
local color_red = Color(255,0,0)
function SWEP:DrawHUD()
    draw.DrawText("ADMIN TOOL", "TEA.HUDFont", ScrW()/2, ScrH()*0.2, color_white, TEXT_ALIGN_CENTER)
    draw.DrawText("Mode: "..name[self:GetMode()], "TEA.HUDFont", ScrW()/2, ScrH()*0.2 + 20, self:GetMode() ~= ADMINTOOL_MODE_SPAWNER and color_red or color_white, TEXT_ALIGN_CENTER)
end

function SWEP:SetMode(mode)
    self:SetDTInt(0, mode)
end

function SWEP:GetMode()
    return self:GetDTInt(0) or 1
end

function SWEP:SetSubMode(mode)
    self:SetDTInt(1, mode)
end

function SWEP:GetSubMode()
    return self:GetDTInt(1)
end

function SWEP:SetSpawning(str)
    self:SetDTString(2, str)
end

function SWEP:GetSpawning()
    return self:GetDTString(2) or ""
end

function SWEP:SetSpawningType(int)
    self:SetDTInt(3, int)
end

function SWEP:GetSpawningType()
    return self:GetDTInt(3)
end

function SWEP:Initialize()
    self:SetHoldType("normal")
    self.SetOptions = {}

    self:SetMode(1)
end

function SWEP:Think()
    if SERVER and !SuperAdminCheck(self:GetOwner()) then
        self:Remove()
        self:GetOwner():PrintMessage(3, "You are not allowed to use this.")
    end
end

local function RoundPos(pos, roundby)
    roundby = roundby or 1
    pos.x = math.Round(pos.x/roundby)*roundby
    pos.y = math.Round(pos.y/roundby)*roundby
    pos.z = math.Round(pos.z/roundby)*roundby
    return pos
end
function SWEP:SpawnIn(spawning, owner, tr, ang)
    if CLIENT then return end
    if self:GetSpawningType() == ADMINTOOL_SPAWNTYPE_ZOMBIE then
        local zm = GAMEMODE.Config["ZombieClasses"][spawning] or GAMEMODE.Config["BossClasses"][spawning]
        local ent = GAMEMODE:CreateZombie(spawning, RoundPos(tr.HitPos), Angle(0,ang.yaw,0), self.SetOptions.XPReward or zm.XPReward, self.SetOptions.CashReward or zm.MoneyReward, self.SetOptions.InfectionRate or zm.InfectionRate, self.SetOptions.BossZombie)
        if ent and ent:IsValid() then
            ent:SetPos(ent:GetPos() + Vector(0,0,8))
            ent:DropToFloor()
        end
        return
    elseif self:GetSpawningType() == ADMINTOOL_SPAWNTYPE_PROPSFLIMSY then
        local tbl = GAMEMODE.FlimsyProps[self:GetSpawning()]
        local prop = ents.Create("prop_flimsy")
		prop:SetModel(self:GetSpawning())
		prop:SetPos(tr.HitPos)
		prop:SetAngles(Angle(0, ang.yaw, 0))
		prop:Spawn()
		prop:Activate()
		prop.IsPropBarricade = true

        local phys = prop:GetPhysicsObject()
		phys:EnableMotion(false)
		prop:SetNWInt("ate_maxintegrity", 500 * (tbl.Toughness or 1))
		prop:SetNWInt("ate_integrity", 500 * (tbl.Toughness or 1))
		prop:SetNWEntity("owner", owner)
        prop:FinishBuild()
        return
    elseif self:GetSpawningType() == ADMINTOOL_SPAWNTYPE_PROPSSTRONG then
        local tbl = GAMEMODE.ToughProps[self:GetSpawning()]
        local prop = ents.Create("prop_strong")
        prop:SetModel(self:GetSpawning())
		prop:SetPos(tr.HitPos)
		prop:SetAngles(Angle(0, ang.yaw, 0))
		prop:Spawn()
		prop:Activate()
		prop.IsPropBarricade = true

        local phys = prop:GetPhysicsObject()
		phys:EnableMotion(false)
		prop:SetNWInt("ate_maxintegrity", 500 * (tbl.Toughness or 1))
		prop:SetNWInt("ate_integrity", 500 * (tbl.Toughness or 1))
		prop:SetNWEntity("owner", owner)
        prop:FinishBuild()
        return
    elseif self:GetSpawningType() == ADMINTOOL_SPAWNTYPE_FACSTRUCTURES then
        local fac = GAMEMODE.SpecialStructureSpawns[self:GetSpawning()]
	    local prop = ents.Create(self:GetSpawning())
	    prop:SetModel(fac.Model)
	    prop:SetPos(tr.HitPos)
	    prop:SetAngles(Angle(0, ang.yaw, 0))
	    prop:Spawn()
	    prop:Activate()

        prop.IsPropBarricade = true
	    local phys = prop:GetPhysicsObject()
	    phys:Wake()
	    phys:EnableMotion(false)
	    prop:SetNWEntity("owner", owner)
        prop:FinishBuild()
        return
    elseif self:GetSpawningType() == ADMINTOOL_SPAWNTYPE_MAPSPAWNS then
        if GAMEMODE.AdminMapSpawnables[self:GetSpawning()] then
            GAMEMODE.AdminMapSpawnables[self:GetSpawning()].Spawn(owner, self, tr, self:GetAimPos())
        end
    elseif self:GetSpawningType() == ADMINTOOL_SPAWNTYPE_TOOL then
        if GAMEMODE.AdminTools[self:GetSpawning()] then
            GAMEMODE.AdminTools[self:GetSpawning()].Spawn(owner, self, tr, self:GetAimPos())
        end
    end
end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    local tr = owner:GetEyeTrace()

    if self:GetMode() == ADMINTOOL_MODE_SPAWNER then
        self:SpawnIn(self:GetSpawning(), owner, tr, owner:EyeAngles())
    elseif self:GetMode() == ADMINTOOL_MODE_DELETE then
        if CLIENT then return end
        local e = tr.Entity
        if e and e:IsValid() then
            if e:IsNPC() or e:IsNextBot() or e:GetClass() == "prop_flimsy" or e:GetClass() == "prop_strong" or GAMEMODE.SpecialStructureSpawns[e:GetClass()] then -- safe mode
                e:Remove()
            end
        end
    elseif self:GetMode() == ADMINTOOL_MODE_DELETEUNSAFE then
        if CLIENT then return end
        local e = tr.Entity
        if e and e:IsValid() then
            e:Remove()
        end
    end
end

function SWEP:SecondaryAttack()
	if game.SinglePlayer() then
        self:GetOwner():SendLua([[gamemode.Call("OpenAdminToolMenuOptions", LocalPlayer():GetWeapon("]]..self:GetClass()..[["))]])
    elseif CLIENT then
        gamemode.Call("OpenAdminToolMenuOptions", self)
    end
end

function SWEP:Reload()
    if self.NextReload and self.NextReload > CurTime() then return end
	if game.SinglePlayer() then
        self:GetOwner():SendLua([[gamemode.Call("OpenAdminToolMenu", LocalPlayer():GetWeapon("]]..self:GetClass()..[["))]])
        self.NextReload = CurTime() + 1
    elseif CLIENT then
        gamemode.Call("OpenAdminToolMenu", self)
        self.NextReload = CurTime() + 1
    end
end

function SWEP:Holster()
    return true
end

function SWEP:GetAimPos()
    local pos = self:GetOwner():GetEyeTrace().HitPos
    pos.x = math.Round(pos.x)
    pos.y = math.Round(pos.y)
    pos.z = math.Round(pos.z)

    return pos
end

local mat = Material("color")
if CLIENT then
    hook.Add("PostDrawOpaqueRenderables", "TEA.AdminTool.Render", function(_, bDrawingSkybox, _)
        if bDrawingSkybox then return end
        local pl = LocalPlayer()
        local wep = pl.GetActiveWeapon and pl:GetActiveWeapon()
        if wep and wep:IsValid() and wep:GetClass() == "tea_admintool" then
            local pos = wep:GetAimPos()

            render.SetMaterial(mat)
            render.DrawSphere(pos, 4, 8, 8, Color(255,0,0,200))

            for t,var in pairs(GAMEMODE.AdminEyes) do
                if GAMEMODE.AdminEyesEnabled[t] and GAMEMODE.AdminMapSpawnables[t] and GAMEMODE.AdminMapSpawnables[t].View then
                    GAMEMODE.AdminMapSpawnables[t].View(pl, var)
                end
            end
        end
    end)
end
