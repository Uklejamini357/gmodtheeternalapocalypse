if SERVER then
    SWEP.Weight = 1 --	AddCSLuaFile("shared.lua") --		AddCSLuaFile("cl_init.lua")
    SWEP.AutoSwitchTo = false
    SWEP.AutoSwitchFrom = false
end

local stacker_mode_enabled
local stacker_mode_dir
if CLIENT then
    SWEP.PrintName = "Build Tool"
    SWEP.DrawCrosshair = true
    SWEP.DrawAmmo = true
    SWEP.ViewModelFOV = 60
    SWEP.ViewModelFlip = false
    SWEP.CSMuzzleFlashes = false
    SWEP.Slot = 5
    SWEP.SlotPos = 0
    CreateClientConVar("tea_buildtool_angle_p", 0, false, true, "", -90, 90)
    CreateClientConVar("tea_buildtool_angle_y", 0, false, true, "", -180, 180)
    CreateClientConVar("tea_buildtool_angle_r", 0, false, true, "", -180, 180)
    CreateClientConVar("tea_buildtool_allow_ang_p", 0, false, true, "", 0, 1)
    CreateClientConVar("tea_buildtool_world_angle", 0, false, true, "", 0, 1)
    CreateClientConVar("tea_buildtool_snap_angle", 0, false, true, "", 0, 90)
    stacker_mode_enabled = CreateClientConVar("tea_buildtool_stacker_mode", 0, false, true, "", 0, 1)
    stacker_mode_dir = CreateClientConVar("tea_buildtool_stacker_dir", 1, false, true, "", 1, 6)
end

SWEP.Author = "LegendofRobbo" --Swep info and other stuff
SWEP.Contact = ""
SWEP.Purpose = "Use this to build your base.\nSalvaging a prop will refund 45% of the prop cost."
SWEP.Instructions = "Click (+attack) to spawn prop\nPress R (+reload) to salvage"
SWEP.AdminSpawnable = false
SWEP.Spawnable = false
SWEP.ViewModel = "models/weapons/v_physcannon.mdl"
SWEP.WorldModel = "models/weapons/w_physics.mdl"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
local stacker_dirs_name = {"Forward", "Backward", "Left", "Right", "Up", "Down"}
function SWEP:DrawHUD()
    if not CLIENT then return false end
    local ply = LocalPlayer()
    local vmodel = ply:GetViewModel()
    local hudpos = vmodel:GetAttachment("1")
    if hudpos then
        pos2 = hudpos.Pos
        local screenpos2 = pos2:ToScreen()
        local x2 = screenpos2.x
        local y2 = screenpos2.y
        surface.SetTextColor(250, 250, 150, 225)
        surface.SetTextPos(x2 - 342, y2 - 52)
        surface.SetFont("TargetID")
        surface.DrawText("Left Click: Spawn Prop")
        surface.SetTextPos(x2 - 342, y2 - 32)
        surface.SetTextPos(x2 - 342, y2 - 124)
        surface.SetTextColor(50, 250, 250, 225)
        surface.DrawText("Stacker Mode: " .. (stacker_mode_enabled:GetBool() and "Enabled" or "Disabled"))
        surface.SetTextPos(x2 - 342, y2 - 104)
        surface.DrawText("Stacker Direction: " .. stacker_dirs_name[stacker_mode_dir:GetInt()])
        surface.SetTextPos(x2 - 342, y2 - 84)
        surface.SetTextColor(150, 250, 250, 225)
        surface.DrawText("Left Click + E: Change stacker direction")
        surface.SetTextPos(x2 - 342, y2 - 24)
        surface.SetTextColor(150, 250, 250, 225)
        surface.DrawText("Right Click: Open Menu")
        surface.SetTextPos(x2 - 342, y2 - 4)
        surface.SetTextColor(150, 250, 250, 225)
        surface.DrawText("R: Salvage Prop (45% refund)")
        surface.SetTextPos(x2 - 342, y2 + 16)
        surface.DrawText("Q: Select a new Prop")
        surface.SetTextPos(x2 - 342, y2 + 36)
        surface.SetTextColor(200, 200, 200, 225)
        if IsValid(self:GetGhost()) then
            local ang = self:GetGhost():GetAngles()
            surface.DrawText(string.format("Current Angles: [%.1f %.1f %.1f]", ang.p, ang.y, ang.r))
        end

        surface.SetTextPos(x2 - 342, y2 + 56)
        surface.SetTextColor(200, 200, 200, 225)
        surface.DrawText("Left Click + ALT: Drag Unbuilt prop")
    end
end

function SWEP:SetupDataTables()
    self:NetworkVar("Entity", 0, "Ghost")
    self:NetworkVar("Entity", 1, "DraggedEnt")
    self:NetworkVar("Vector", 0, "DraggedEntLPos")
end

function SWEP:Reload()
    if not SERVER then return false end
    local tr = {}
    tr.start = self:GetOwner():GetShootPos()
    tr.endpos = self:GetOwner():GetShootPos() + 150 * self:GetOwner():GetAimVector()
    tr.filter = {self:GetOwner()}
    local trace = util.TraceLine(tr)
    if trace.Entity and trace.Entity:IsValid() and (trace.Entity:GetClass() == "prop_flimsy" or trace.Entity:GetClass() == "prop_strong") and (self:GetNextPrimaryFire() <= CurTime()) then
        GAMEMODE:DestroyProp(self:GetOwner(), trace.Entity)
        self:SetNextPrimaryFire(CurTime() + 2.08)
    elseif trace.Entity and trace.Entity:IsValid() and SpecialSpawns[trace.Entity:GetClass()] and (self:GetNextPrimaryFire() <= CurTime()) then
        GAMEMODE:DestroyStructure(self:GetOwner(), trace.Entity)
        self:SetNextPrimaryFire(CurTime() + 2.08)
    end
end

local stacker_dirs = {Vector(1, 0, 0), Vector(-1, 0, 0), Vector(0, 1, 0), Vector(0, -1, 0), Vector(0, 0, 1), Vector(0, 0, -1),}
local dist = {function(min, max) return math.abs(max.x - min.x) end, function(min, max) return math.abs(max.x - min.x) end, function(min, max) return math.abs(max.y - min.y) end, function(min, max) return math.abs(max.y - min.y) end, function(min, max) return math.abs(max.z - min.z) end, function(min, max) return math.abs(max.z - min.z) end,}
function SWEP:GetBuildPos(f)
    local ply = self:GetOwner()
    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()
    local trace = {}
    trace.start = vStart
    trace.endpos = vStart + (vForward * 150)
    trace.filter = {ply, f}
    local tr = util.TraceLine(trace)
    local stacker_mode = tobool(ply:GetInfo("tea_buildtool_stacker_mode", "0"))
    local stacker_dir = ply:GetInfo("tea_buildtool_stacker_dir", "1")
    if stacker_mode and IsValid(tr.Entity) then
        local dir = stacker_dirs[tonumber(stacker_dir) or 1] or stacker_dirs[1]
        local offset = Vector()
        offset:Set(dir * dist[tonumber(stacker_dir) or 1](tr.Entity:OBBMins(), tr.Entity:OBBMaxs()))
        offset = offset - Vector(1, 1, 1) / 2 * dir
        offset:Rotate(tr.Entity:GetAngles())
        tr.HitPos = tr.Entity:LocalToWorld(Vector(0, 0, 0)) + offset --[[tr.Entity:OBBCenter()--]]
    end

    self.AimedEntity = tr.Entity
    return tr.HitPos
end

function SWEP:GetBuildAngles(f)
    local ply = self:GetOwner()
    local ang = ply:EyeAngles()
    if ply:KeyDown(IN_SPEED) and ply:GetInfoNum("tea_buildtool_snap_angle", 0) ~= 0 then ang.y = math.SnapTo(ang.y, math.abs(ply:GetInfoNum("tea_buildtool_snap_angle", 0))) end
    if not tobool(ply:GetInfo("tea_buildtool_allow_ang_p", "0")) then ang.p = 0 end
    if tobool(ply:GetInfo("tea_buildtool_world_angle", "0")) then ang = Angle(0,0,0) end
    local stacker_mode = tobool(ply:GetInfo("tea_buildtool_stacker_mode", "0"))
    if stacker_mode and IsValid(self.AimedEntity) then ang = self.AimedEntity:GetAngles() end
    local p, y, r = ply:GetInfoNum("tea_buildtool_angle_p", 0), ply:GetInfoNum("tea_buildtool_angle_y", 0), ply:GetInfoNum("tea_buildtool_angle_r", 0)
    ang:RotateAroundAxis(ang:Right(), p)
    ang:RotateAroundAxis(ang:Up(), y)
    ang:RotateAroundAxis(ang:Forward(), r)
    return ang
end

function SWEP:GetSelected()
    local ply = self:GetOwner()
    return ply.SelectedProp or "models/props_debris/wood_board04a.mdl"
end

local class = {
    prop_flimsy = true,
    prop_strong = true,
}

function SWEP:PrimaryAttack()
    if self:GetOwner():KeyDown(IN_WALK) and SERVER then
        if not IsValid(self:GetDraggedEnt()) then
            local ply = self:GetOwner()
            local vStart = ply:GetShootPos()
            local vForward = ply:GetAimVector()
            local trace = {}
            trace.start = vStart
            trace.endpos = vStart + (vForward * 150)
            trace.filter = ply
            local tr = util.TraceLine(trace)
            if IsValid(tr.Entity) and class[tr.Entity:GetClass()] and not tr.Entity.IsBuilt then
                self:SetDraggedEnt(tr.Entity)
                self:SetDraggedEntLPos(tr.Entity:WorldToLocal(tr.HitPos))
            end
        end
    elseif SERVER and IsValid(self:GetDraggedEnt()) then
        self:SetDraggedEnt(NULL)
        return
    end

    if IsValid(self:GetDraggedEnt()) or self:GetOwner():KeyDown(IN_WALK) then return end
    if self:GetOwner():KeyDown(IN_USE) and CLIENT and IsFirstTimePredicted() then
        local i = stacker_mode_dir:GetInt() + 1
        if i > 6 then i = 1 end
        RunConsoleCommand("tea_buildtool_stacker_dir", i)
    end

    if not SERVER then return false end
    if not IsFirstTimePredicted() then return end
    local ply = self:GetOwner()
    if ply:KeyDown(IN_USE) then return end
    if (self:GetNextPrimaryFire() <= CurTime()) then
        GAMEMODE:MakeProp(ply, self:GetSelected(), self:GetBuildPos(), self:GetBuildAngles(), 1)
        self:SetNextPrimaryFire(CurTime() + 0.5)
    end
end

function SWEP:SecondaryAttack()
    if SERVER then return end
    if self:GetNextSecondaryFire() > CurTime() then return false end
    if not IsFirstTimePredicted() then return end

    local DFrame = vgui.Create("DFrame")
    DFrame:SetSize(ScrW() / 2.8, ScrH() / 4.0)
    DFrame:SetTitle("Building Menu")
    DFrame:InvalidateLayout(true)
    DFrame:SetPos(0, ScrH() * 0.985 - DFrame:GetTall())
    DFrame:CenterHorizontal(0.185)
    DFrame:MakePopup()
    local DScrollPanel = vgui.Create("DScrollPanel", DFrame)
    DScrollPanel:Dock(FILL)
    local panel = vgui.Create("DPanel")
    local model = vgui.Create("DModelPanel", panel)
    model:Dock(FILL)
    model:SetModel(self:GetGhost():GetModel())
    function model.LayoutEntity(model, ent)
        if not IsValid(self:GetGhost()) then return end
        ent:SetAngles(self:GetGhost():GetAngles())
        model:SetCamPos(LocalPlayer():GetAimVector() * -(30 + ent:GetModelRadius() * 2))
    end

    model:SetFOV(40)
    model:SetLookAng(LocalPlayer():GetAimVector():Angle())
    model:SetSize(72, 72)
    panel:SetSize(72, 72)
    panel:Dock(LEFT)
    panel:DockMargin(2, 0, 5, 0)
    DScrollPanel:AddItem(panel)

    local angle_p = vgui.Create("DNumSlider")
    angle_p:SetText("Pitch offset")
    angle_p:SetDecimals(1)
    angle_p:SetMin(-90)
    angle_p:SetMax(90)
    angle_p:SetConVar("tea_buildtool_angle_p")
    angle_p:Dock(TOP)
    DScrollPanel:AddItem(angle_p)

    local angle_y = vgui.Create("DNumSlider")
    angle_y:SetText("Yaw offset")
    angle_y:SetDecimals(1)
    angle_y:SetMin(-180)
    angle_y:SetMax(180)
    angle_y:SetConVar("tea_buildtool_angle_y")
    angle_y:Dock(TOP)
    DScrollPanel:AddItem(angle_y)

    local angle_r = vgui.Create("DNumSlider")
    angle_r:SetText("Roll offset")
    angle_r:SetDecimals(1)
    angle_r:SetMin(-180)
    angle_r:SetMax(180)
    angle_r:SetConVar("tea_buildtool_angle_r")
    angle_r:Dock(TOP)
    DScrollPanel:AddItem(angle_r)

    local angle_reset = vgui.Create("DButton")
    angle_reset:SetText("Reset Angles")
    angle_reset:Dock(TOP)
	function angle_reset:DoClick()
		GetConVar("tea_buildtool_angle_p"):SetFloat(0)
		GetConVar("tea_buildtool_angle_y"):SetFloat(0)
		GetConVar("tea_buildtool_angle_r"):SetFloat(0)
	end
    DScrollPanel:AddItem(angle_reset)

    local allow_p = vgui.Create("DCheckBoxLabel")
    allow_p:SetText("Allow Pitch?")
    allow_p:SetConVar("tea_buildtool_allow_ang_p")
    allow_p:SizeToContents()
    allow_p:Dock(TOP)
    allow_p:DockMargin(0, 5, 0, 0)
    DScrollPanel:AddItem(allow_p)

    local world_ang = vgui.Create("DCheckBoxLabel")
    world_ang:SetText("Use world angles?")
    world_ang:SetConVar("tea_buildtool_world_angle")
    world_ang:SizeToContents()
    world_ang:Dock(TOP)
    world_ang:DockMargin(0, 5, 0, 0)
    DScrollPanel:AddItem(world_ang)

    local stacker_mode = vgui.Create("DCheckBoxLabel")
    stacker_mode:SetText("Stacker Mode?")
    stacker_mode:SetConVar("tea_buildtool_stacker_mode")
    stacker_mode:SizeToContents()
    stacker_mode:Dock(TOP)
    stacker_mode:DockMargin(0, 15, 0, 0)
    DScrollPanel:AddItem(stacker_mode)

    local stacker_dir = vgui.Create("DComboBox")
    stacker_dir:SetValue("Stacker Direction")
    stacker_dir:SetSortItems(false)
    stacker_dir:AddChoice("Forward", 1)
    stacker_dir:AddChoice("Backward", 2)
    stacker_dir:AddChoice("Left", 3)
    stacker_dir:AddChoice("Right", 4)
    stacker_dir:AddChoice("Up", 5)
    stacker_dir:AddChoice("Down", 6)
    stacker_dir:SetConVar("tea_buildtool_stacker_dir")
    stacker_dir:SizeToContents()
    stacker_dir:Dock(TOP)
    stacker_dir:DockMargin(0, 2, 0, 0)
    function stacker_dir:OnSelect(index, value, data)
        RunConsoleCommand("tea_buildtool_stacker_dir", data)
    end

    DScrollPanel:AddItem(stacker_dir)
    self:SetNextSecondaryFire(CurTime() + 0.5)
end

function SWEP:Holster()
    self:SetDraggedEnt(NULL)
    if SERVER and IsValid(self:GetGhost()) then self:GetGhost():Remove() end
    return true
end

function SWEP:OnRemove()
    self:Holster()
end

function SWEP:Think()
    if SERVER then
        if not IsValid(self:GetGhost()) then 
            self:SetGhost(ents.Create("prop_dynamic"))
            self:GetGhost():SetModel(self:GetSelected())
            self:GetGhost():Spawn()
            self:GetGhost():Activate()
            self:GetGhost():SetNotSolid(true)
        end

        local ghost = self:GetGhost()
        ghost:SetPos(self:GetBuildPos())
        ghost:SetAngles(self:GetBuildAngles())
        ghost:SetModel(self:GetSelected())
        ghost:SetMaterial("models/wireframe")
        ghost:SetColor(Color(255, 255, 255, 188))
        ghost:SetRenderMode(RENDERMODE_TRANSCOLOR)
        if IsValid(self:GetDraggedEnt()) then
            ghost:SetNoDraw(true)
            local ent = self:GetDraggedEnt()
            local Invalid = function() self:SetDraggedEnt(NULL) end
            if ent.IsBuilt then
                Invalid()
                return
            end

            ent:SetPos(self:GetBuildPos(ent))
            ent:SetAngles(self:GetBuildAngles(ent))
        else
            ghost:SetNoDraw(false)
        end
    end
end

local halo_clr_drag = Color(0, 255, 0)
local halo_clr_ghost = Color(255, 255, 0)
local halo_clr = Color(255, 255, 255)
hook.Add("PreDrawHalos", "tea_buildtool halo", function()
    local wep = LocalPlayer():GetActiveWeapon()
    if IsValid(wep) and wep:GetClass() == "tea_buildtool" then
        local tbl = {}
        local l = 0
        local clr = halo_clr
        if IsValid(wep:GetDraggedEnt()) then
            l = l + 1
            tbl[l] = wep:GetDraggedEnt()
            clr = halo_clr_drag
        elseif IsValid(wep:GetGhost()) and not wep:GetGhost():GetNoDraw() then
            l = l + 1
            tbl[l] = wep:GetGhost()
            clr = halo_clr_ghost
        end

        halo.Add(tbl, clr, 1, 1, 5, true, true)
    end
end)