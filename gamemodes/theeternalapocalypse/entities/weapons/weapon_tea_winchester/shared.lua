SWEP.Base 				= "weapon_tea_base_shotgun"

SWEP.ViewModelFlip		= true
SWEP.ViewModel			= "models/weapons/v_winchester1873.mdl"
SWEP.WorldModel			= "models/weapons/w_winchester_1873.mdl"
SWEP.HoldType			= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 65
SWEP.Shotgun			= true

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "They don't call this the WINchester for nothing amirite"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses magnum rounds"

SWEP.Primary.Sound 		= Sound("Weapon_73.Single")
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 65
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.008
SWEP.Primary.Delay 		= 0.95

SWEP.IronFireAccel		= 1.25

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"


SWEP.ShellDelay			= 0.53

SWEP.IronSightsPos = Vector(4.36, -2.935, 2.572)
SWEP.IronSightsAng = Vector(0, 0, 0)


SWEP.RunArmOffset = Vector(11.26, 0, 0)

SWEP.RunArmAngle = Vector(-7.441, 36.102, 0)

SWEP.ZWweight				= 85 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Common" -- Junk, Common, Uncommon, Rare, Epic

function SWEP:Precache()

    	util.PrecacheSound("weapons/m3/m3-1.wav")
end


/*---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: Reload is being pressed.
---------------------------------------------------------*/
function SWEP:Reload()

	if (self.ActionDelay > CurTime()) then return end 

	if (self.Weapon:GetNWBool("Reloading") or self.ShotgunReloading) then return end

	if (self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self.ShotgunReloading = true
		self.Weapon:SetNextPrimaryFire(CurTime() + self.ShotgunBeginReload + 0.1)
		self.Weapon:SetNextSecondaryFire(CurTime() + self.ShotgunBeginReload + 0.1)
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

		timer.Simple(self.ShotgunBeginReload, function()
			self.ShotgunReloading = false
			self.Weapon:SetNetworkedBool("Reloading", true)
			self.Weapon:SetVar("ReloadTime", CurTime() + 1)
			self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
			self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
		end)

		if (SERVER) then
			self.Owner:SetFOV( 0, 0.15 )
			self:SetIronsights(false)
		end
	end
end




function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone)

	num_bullets 		= num_bullets or 1
	aimcone 			= aimcone or 0

	self:ShootEffects()

	if self.Tracer == 1 then
		TracerName = "Ar2Tracer"
	elseif self.Tracer == 2 then
		TracerName = "AirboatGunHeavyTracer"
	else
		TracerName = "Tracer"
	end
	
	local bullet = {}
		bullet.Num 		= num_bullets
		bullet.Src 		= self.Owner:GetShootPos()			// Source
		bullet.Dir 		= self.Owner:GetAimVector()			// Dir of bullet
		bullet.Spread 	= Vector(aimcone, aimcone, 0)			// Aim Cone
		bullet.Tracer	= 1							// Show a tracer on every x bullets
		bullet.TracerName = TracerName
		bullet.Force	= damage * 0.5					// Amount of force to give to phys objects
		bullet.Damage	= damage
		bullet.Callback	= function(attacker, tr, dmginfo) 
						if not self.Owner:IsNPC() and self.Owner:GetNetworkedInt("Fuel") > 0 then
							self:ShootFire(attacker, tr, dmginfo) 
						end

						if tr.Entity:GetClass() == "prop_vehicle_prisoner_pod" then
							if SERVER then
							tr.Entity:TakeDamage(damage, self:GetOwner())
							end
						end

						if tr.Entity.Type == "nextbot" then
							bullet.Damage = bullet.Damage * 2
						end

						if tr.Entity:IsPlayer() == true or tr.Entity:IsNPC() == true or tr.Entity.Type == "nextbot" then
						if SERVER then
						if self.Sniper == true then
						 net.Start( "HitMarkerSnip" )
   						net.Send( self.Owner )
   						else
   						net.Start( "HitMarker" )
   						net.Send( self.Owner )
   						end
   						end
						end

--						return self:RicochetCallback_Redirect(attacker, tr, dmginfo) 
					  end

	self.Owner:FireBullets(bullet)

	// Realistic recoil. Only on snipers and shotguns. Disable for the admin gun because if you put the max damage, you'll fly like you never fly!
	if (SERVER and (self.Sniper or self.Shotgun) and not self.Owner:GetActiveWeapon():GetClass() == ("weapon_mad_admin")) then
		self.Owner:SetVelocity(self.Owner:GetAimVector() * -(damage * num_bullets))
	end

	// Recoil
	if (not self.Owner:IsNPC()) and ((game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and CLIENT)) then
		if ( IsFirstTimePredicted() ) then
		local eyeangle 	= self.Owner:EyeAngles()
		eyeangle.pitch 	= eyeangle.pitch - recoil
		self.Owner:SetEyeAngles(eyeangle)
		end
	end
end