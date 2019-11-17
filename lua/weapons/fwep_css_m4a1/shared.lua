SWEP.PrintName			= "M4A1" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = true
SWEP.Base			= "fwep_css_revolver"
SWEP.Category	= "FSweps"

SWEP.Primary.Damage			= 29
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"
SWEP.Primary.Delay			= 0.086
SWEP.Primary.Sound			= "weapons/m4a1/m4a1_unsil-1.wav"
SWEP.Primary.Cone			= 0.02

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.01
SWEP.Secondary.FOV			= 20

SWEP.HoldType				= "ar2"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 0.4

local reloaddelay = 0

SWEP.SwayScale = 0.5
SWEP.BobScale = 0.8

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0



-- Adjust these variables to move the viewmodel's position
-- M4A1 EXCLUSIVE: Does not take anims from here, see down below in the think func.

--SWEP.IronSightsPos = Vector(-7.74, -7.354, -1)
--SWEP.IronSightsAng = Vector(6.5, -1.351, -3.429)

SWEP.SprintGunPos = Vector(-05,-20,-20)
SWEP.SprintGunAng = Vector(50,70,-10)

SWEP.IdleGunPos = Vector(0,0,0)
SWEP.IdleGunAng = Vector(0,0,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.025
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.021

-- the following is to fix the anus tier viewmodel for the m4a1

function SWEP:TranslateFOV( fov )

	if self.Owner:GetNWBool("isaiming") == true then
		return fov - (self.Secondary.FOV * (1 - iteratorthing))
	else
		return fov - (self.Secondary.FOV * (1 - iteratorthing))
	end
	
	
end

function SWEP:Think()

	if self.Weapon:Clip1() != self.Weapon:GetMaxClip1() then
		self.IronSightsPos = Vector(-7.9, -7.354, 0.36)
		self.IronSightsAng = Vector(3.6, -2.65, -5)

	else
		self.IronSightsPos = Vector(-7.65, -7.354, 0.36)
		self.IronSightsAng = Vector(2.9, -1.32, -3.429)
	end

	if CLIENT then

		if self.Owner == nil then return end

		if self.Owner:Crouching() == true then
			heightmodifier = 32
		else
			heightmodifier = 64
		end

		if (self.Owner:IsSprinting() and self.Owner:GetNWBool("isaiming") == false) and (self.Weapon.AllowSprintAng) then

			if iteratorthing2 > 0 then 
				iteratorthing2 = iteratorthing2 - self.Weapon.sprintmodifier
			end 
		else
			if iteratorthing2 <= 1 then 
				iteratorthing2 = iteratorthing2 + self.Weapon.sprintmodifier
			
			end 
			
		end

		iteratorthing2 = math.Clamp(iteratorthing2, 0, 1)
		
		if self.Owner:GetNWBool("isaiming") == true then
			self.BobScale = 0.1
		else
			self.BobScale = self.BobScaleBackup
			
		end 

		if self.Owner:GetNWBool("isaiming") == true && iteratorthing > 0 then
			iteratorthing = iteratorthing - self.Weapon.modifier
			
		end
		if self.Owner:GetNWBool("isaiming") == false && iteratorthing <= 1 then
			iteratorthing = iteratorthing + self.Weapon.modifier
		end

		iteratorthing = math.Clamp(iteratorthing, 0, 1)
		
		self.CurrentGunPos = LerpVector(iteratorthing, self.IronSightsPos , self.IdleGunPos) + LerpVector(iteratorthing2, self.SprintGunPos , Vector(0,0,0))
		self.CurrentGunAng = LerpVector(iteratorthing, self.IronSightsAng , self.IdleGunAng) + LerpVector(iteratorthing2, self.SprintGunAng , Vector(0,0,0))
	end
end