AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("ai_translations.lua")
include("shared.lua")

SWEP.Weight					= 5		// Decides whether we should switch from/to this
SWEP.AutoSwitchTo				= true	// Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true	// Auto switch from if you pick up a better weapon

/*---------------------------------------------------------
   Name: SWEP:TranslateActivity()
   Desc: Translate a player's activity into a weapon's activity.
	   So for example, ACT_HL2MP_RUN becomes ACT_HL2MP_RUN_PISTOL
	   depending on how you want the player to be holding the weapon.
---------------------------------------------------------*/
function SWEP:TranslateActivity(act)

	if (self.Owner:IsNPC()) then
		if (self.ActivityTranslateAI[act]) then
			return self.ActivityTranslateAI[act]
		end

		return -1
	end

	if (self.ActivityTranslate[act] != nil) then
		return self.ActivityTranslate[act]
	end
	
	return -1
end

/*---------------------------------------------------------
   Name: SWEP:NPCShoot_Primary()
   Desc: NPC tried to fire primary attack.
---------------------------------------------------------*/
function SWEP:NPCShoot_Primary(ShootPos, ShootDir)

	self:PrimaryAttack()
end

/*---------------------------------------------------------
   Name: SWEP:NPCShoot_Secondary()
   Desc: NPC tried to fire secondary attack.
---------------------------------------------------------*/
function SWEP:NPCShoot_Secondary(ShootPos, ShootDir)
end

/*---------------------------------------------------------
   Name: SWEP:NPCShoot_Bullet()
---------------------------------------------------------*/
function SWEP:NPCShoot_Bullet(damage, recoil, num_bullets, aimcone)

	num_bullets 		= num_bullets or 1
	aimcone 			= aimcone or 0
	
	local bullet = {}
		bullet.Num 		= num_bullets
		bullet.Src 		= self.Owner:GetShootPos()			// Source
		bullet.Dir 		= self.Owner:GetAimVector()			// Dir of bullet
		bullet.Spread 	= Vector(aimcone, aimcone, 0)			// Aim Cone
		bullet.Tracer	= 1							// Show a tracer on every x bullets
		bullet.TracerName = "Tracer"
		bullet.Force	= damage * 0.5					// Amount of force to give to phys objects
		bullet.Damage	= damage
		bullet.Callback	= function(a, b, c) return self:RicochetCallback_Redirect(a, b, c) end	

	self.Owner:FireBullets(bullet)
	self:ShootEffects()
end