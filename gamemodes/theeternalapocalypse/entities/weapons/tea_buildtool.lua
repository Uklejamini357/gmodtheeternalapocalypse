if (SERVER) then
--	AddCSLuaFile("shared.lua")
--		AddCSLuaFile("cl_init.lua")
	SWEP.Weight				= 1
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if (CLIENT) then
	SWEP.PrintName			= "Build Tool"
	SWEP.DrawCrosshair		= true
	SWEP.DrawAmmo			= true
	SWEP.ViewModelFOV		= 60
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	SWEP.Slot = 5
	SWEP.SlotPos = 0
end

--Swep info and other stuff
SWEP.Author	= "LegendofRobbo"
SWEP.Contact = ""
SWEP.Purpose = "Use this to build your base.\nSalvaging a prop will refund 45% of the prop cost."
SWEP.Instructions = "Click (+attack) to spawn prop\nPress R (+reload) to salvage"
SWEP.AdminSpawnable	= false
SWEP.Spawnable	= false
SWEP.ViewModel	= "models/weapons/v_physcannon.mdl"
SWEP.WorldModel	= "models/weapons/w_physics.mdl"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo	= "none"

function SWEP:DrawHUD()
if not (CLIENT) then return false end

	local hitpos = util.TraceLine ({
		start = LocalPlayer():GetShootPos(),
		endpos = LocalPlayer():GetShootPos() + LocalPlayer():GetAimVector() * 4096,
		filter = LocalPlayer(),
		mask = MASK_SHOT
	}).HitPos

	local screenpos = hitpos:ToScreen()
	
	local x = screenpos.x
	local y = screenpos.y

	local ply = LocalPlayer()
	local weapon = ply:GetActiveWeapon()
	local vmodel = ply:GetViewModel()
	local hudpos = vmodel:GetAttachment("1")
	local caxis = self:GetChangeAxis()
	local moda
	if caxis == 0 then
	moda = "Pitch"
	elseif caxis == 1 then
	moda = "Yaw"
	else
	moda = "Roll"
	end

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
	surface.DrawText("Right Click: Change Rotation Axis")
	surface.SetTextColor(150, 250, 250, 225)
	surface.SetTextPos(x2 - 342, y2 - 12)
	surface.DrawText("E + Left or Right Click: Rotate Prop")
	surface.SetTextPos(x2 - 342, y2 + 8)
	surface.DrawText("Left Click + R: Reset Orientation")
	surface.SetTextPos(x2 - 342, y2 + 28)
	surface.DrawText("R: Salvage Prop (45% refund)")
	surface.SetTextPos(x2 - 342, y2 + 48)
	surface.DrawText("Q: Select a new Prop")
	surface.SetTextPos(x2 - 342, y2 + 68)
	surface.SetTextColor(150, 250, 150, 225)
	surface.DrawText("Current Axis: "..moda)
	surface.SetTextPos(x2 - 342, y2 + 88)
	surface.SetTextColor(200, 200, 200, 225)
	surface.DrawText("Current Angles: Pitch "..weapon:GetBPitch().." Yaw "..weapon:GetBYaw().. " Roll "..weapon:GetBRoll())
	surface.SetTextPos(x2 - 342, y2 + 108)
	surface.SetTextColor(200, 250, 200, 225)
	surface.DrawText("Tip: Hold down ALT while rotating")
	surface.SetTextPos(x2 - 342, y2 + 128)
	surface.SetTextColor(200, 250, 200, 225)
	surface.DrawText("prop to increase rotation rate by upto 20")
end
end


function SWEP:SetupDataTables()
	self:NetworkVar("Entity",0,"ghost")
	self:NetworkVar("Float",0,"BPitch")
	self:NetworkVar("Float",1,"BYaw")
	self:NetworkVar("Float",2,"BRoll")
	self:NetworkVar("Float",3,"ChangeAxis")

end
/*
function SWEP:SendProp(model, pos, angles)
if !CLIENT then return false end
if timer.Exists("tcanplace") then return false
else
timer.Create("tcanplace", 1, 1, function() CanPlace = true timer.Destroy("tcanplace") end)
CanPlace = false
net.Start( "MakeProp" )
net.WriteString( model )
net.WriteVector(pos)
net.WriteAngle(angles)
net.SendToServer()
end
end
*/

function SWEP:Reload()
	if !SERVER then return false end
	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + 150 * self.Owner:GetAimVector()
	tr.filter = {self.Owner}
	local trace = util.TraceLine(tr)

	if trace.Entity and trace.Entity:IsValid() and (trace.Entity:GetClass() == "prop_flimsy" or trace.Entity:GetClass() == "prop_strong") and not (self.Weapon:GetNextPrimaryFire() > CurTime() ) then
		DestroyProp(self.Owner, trace.Entity)
		self:SetNextPrimaryFire(CurTime() + 2.08)
	elseif trace.Entity and trace.Entity:IsValid() and SpecialSpawns[trace.Entity:GetClass()] and not (self.Weapon:GetNextPrimaryFire() > CurTime() ) then
		DestroyStructure(self.Owner, trace.Entity)
		self:SetNextPrimaryFire(CurTime() + 2.08)
	end

end

function SWEP:PrimaryAttack()
if !SERVER then return false end
local caxis = self:GetChangeAxis()

if self.Owner:KeyDown(IN_RELOAD) then
if !(self.Weapon:GetNextPrimaryFire() > CurTime()) then
self:SetBPitch(0)
self:SetBYaw(0)
self:SetBRoll(0)
self.Owner:ConCommand("playgamesound items/ammocrate_open.wav")
self:SetNextPrimaryFire(CurTime() + 0.5)
end
end

if self.Owner:KeyDown(IN_USE) then

if caxis == 0 then
		local pitch = self:GetBPitch()
		if self.Owner:KeyDown(IN_WALK) then
			if pitch < 20 then self:SetBPitch(pitch + 340) else
			self:SetBPitch(pitch - 20)
		end
	else
		if pitch < 5 then self:SetBPitch(pitch + 355) else
			self:SetBPitch(pitch - 5)
		end
		end
elseif caxis == 1 then
		local yaw = self:GetBYaw()
		if self.Owner:KeyDown(IN_WALK) then
			if yaw < 20 then self:SetBYaw(yaw + 340) else
			self:SetBYaw(yaw - 20)
		end
	else
		if yaw < 5 then self:SetBYaw(yaw + 355) else
		self:SetBYaw(yaw - 5)
		end
		end
elseif caxis == 2 then
		local roll = self:GetBRoll()
		if self.Owner:KeyDown(IN_WALK) then
			if roll < 20 then self:SetBRoll(roll + 340) else
			self:SetBRoll(roll - 20)
		end
	else
		if roll < 5 then self:SetBRoll(roll + 355) else
		self:SetBRoll(roll - 5)
		end
	end
	end
	self:SetNextPrimaryFire(CurTime() + 0.15)
return
end

	local ply = self.Owner
	local ang = self.Owner:EyeAngles()
	ang.yaw = ang.yaw + 180 + self:GetBYaw()
	ang.roll = self:GetBRoll()
	ang.pitch = self:GetBPitch()
	local pmodel = SelectedProp
--	if pmodel == "" then pmodel = "models/props_debris/wood_board04a.mdl" end

    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()
    local trace = {}
    trace.start = vStart
    trace.endpos = vStart + (vForward * 150)
    trace.filter = ply
    local tr = util.TraceLine( trace )

    if not (self.Weapon:GetNextPrimaryFire() > CurTime() ) then
    MakeProp(self.Owner, self.Owner.SelectedProp, tr.HitPos, ang, 1)
    self:SetNextPrimaryFire(CurTime() + 0.7)
	end

--    self:SendProp(pmodel, tr.HitPos, ang)
end

function SWEP:SecondaryAttack()
if self.Weapon:GetNextSecondaryFire() > CurTime() then return false end
-- if not IsFirstTimePredicted() then return false end
local caxis = self:GetChangeAxis()

if self.Owner:KeyDown(IN_USE) then
if caxis == 0 then
		local pitch = self:GetBPitch()
		if self.Owner:KeyDown(IN_WALK) then
			if pitch >= 340 then self:SetBPitch(pitch - 340) else
			self:SetBPitch(pitch + 20)
		end
	else
		if pitch >= 355 then self:SetBPitch(pitch - 355) else
			self:SetBPitch(pitch + 5)
		end
		end
elseif caxis == 1 then
		local yaw = self:GetBYaw()
		if self.Owner:KeyDown(IN_WALK) then
			if yaw >= 340 then self:SetBYaw(yaw - 340) else
			self:SetBYaw(yaw + 20)
		end
	else
		if yaw >= 355 then self:SetBYaw(yaw - 355) else
		self:SetBYaw(yaw + 5)
		end
		end
elseif caxis == 2 then
		local roll = self:GetBRoll()
		if self.Owner:KeyDown(IN_WALK) then
			if roll >= 340 then self:SetBRoll(roll - 340) else
			self:SetBRoll(roll + 20)
		end
	else
		if roll >= 355 then self:SetBRoll(roll - 355) else
		self:SetBRoll(roll + 5)
		end
	end
	end
self:SetNextSecondaryFire(CurTime() + 0.15)
return
end

if caxis < 2 then
self:SetChangeAxis(caxis + 1)
else
self:SetChangeAxis(0)
end
self.Owner:ConCommand("play items/ammocrate_close.wav")
-- self.Owner:EmitSound(Sound("items/ammocrate_close.wav"), 70, 100)
self:SetNextPrimaryFire(CurTime() + 0.25)
self:SetNextSecondaryFire(CurTime() + 0.25)
	
end


if CLIENT then
	function SWEP:OnRemove()
		if IsValid(self:GetDTEntity(0)) then
			self:GetDTEntity(0):Remove()
		elseif IsValid(self.Ghost) then
			self.Ghost:Remove()
		end
	end

	function SWEP:Holster()
		if IsValid(self:GetDTEntity(0)) then
			self:GetDTEntity(0):Remove()
		elseif IsValid(self.Ghost) then
			self.Ghost:Remove()
		end
	end

	function SWEP:AdjustMouseSensitivity()
		if self.IsRotating == true then
			return 0
		end
		return 1
	end
end


/*---------------------------------------------------------
   Name: SWEP:Think()
   Desc: Called every frame while the weapon is equipped.
---------------------------------------------------------*/
function SWEP:Think()
	if CLIENT then
	local pmodel = SelectedProp
	if pmodel == "" then pmodel = "models/props_debris/wood_board04a.mdl" end

	if self.Owner ~= LocalPlayer() then return end

	if not IsValid(self.Ghost) then
		self.Ghost = ents.CreateClientProp(pmodel)
		self.Ghost:SetOwner(self.Owner)
		self.Ghost:SetRenderMode(RENDERMODE_TRANSALPHA)
		self:SetDTEntity(0,self.Ghost)
	elseif self.Ghost:GetModel() != pmodel then
		self.Ghost:SetModel(pmodel)
	end

	if not IsValid(self.Ghost) then return end
	//self.Ghost:SetModel(prop)

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + 150 * self.Owner:GetAimVector()
	tr.filter = {self.Ghost, self.Owner}
	local trace = util.TraceLine(tr)

--	if trace.Hit then
		local ang = self.Owner:EyeAngles()
		ang.yaw = ang.yaw + 180 + self:GetBYaw()
		ang.roll = self:GetBRoll()
		ang.pitch = self:GetBPitch()
		local vec = trace.HitPos
			local maxs = self.Ghost:OBBMaxs()
			local mins = self.Ghost:OBBMins()
			local height = maxs.Z - mins.Z
			vec.Z = vec.Z

		ang.yaw = ang.yaw + (self.PYaw or 0)
		ang.pitch = ang.pitch + (self.PPitch or 0)
		ang.roll = ang.roll + (self.PRoll or 0)
		vec.Z = vec.Z + (self.PHeight or 0)

		self.Ghost:SetPos(vec + trace.HitNormal)

		self.Ghost:SetAngles(ang)
		self.Ghost:SetColor(Color(255, 255, 255, 100))

	end
--	else
--		self.Ghost:SetColor(Color(255, 255, 255, 0))
--	end
/*
	local cmd = self.Owner:GetCurrentCommand()
	if cmd:KeyDown(IN_USE) then
		if self.Menu then 
			if self.Menu:IsValid() then
				if self.Menu:IsVisible() then return end
				gui.EnableScreenClicker( true )
				self.Menu:SetVisible(true)
				return
			//else
			//	self.Menu = nil
			end
		end
		gui.EnableScreenClicker( true )

		self.Menu = vgui.Create("onslaught_propedit")
		self.Menu.Target = self
	elseif self.Menu and self.Menu:IsVisible() then
		gui.EnableScreenClicker(false)
		self.Menu:Close()
	end
*/
end