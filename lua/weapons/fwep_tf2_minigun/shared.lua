SWEP.PrintName			= "[TF2] Minigun" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = false
SWEP.Base			= "fwep_css_revolver"
SWEP.Category	= "FSweps [TF2]"

SWEP.Primary.Damage			= 15
SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"
SWEP.Primary.Delay			= 0.07
SWEP.Primary.Sound			= "weapons/pistol/pistol_fire2.wav"
SWEP.Primary.Cone			= 0.045

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.018
SWEP.Secondary.FOV			= 20

SWEP.HoldType				= "physgun"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/v_models/v_minigun_heavy.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_minigun.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 0

local reloaddelay = 0

SWEP.SwayScale = 1
SWEP.BobScale = 1

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0

local spooldelay = 0


-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector( -6.6, -15, 2.5 )
SWEP.IronSightsAng = Vector( 3, 0.1, 0 ) 

SWEP.SprintGunPos = Vector(0,0,0)
SWEP.SprintGunAng = Vector(0,0,0)

SWEP.IdleGunPos = Vector(0,0,0)
SWEP.IdleGunAng = Vector(0,0,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.05
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.04


function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	
	self.BobScaleBackup = self.BobScale
	if CLIENT then
		PrintTable(self.Owner:GetViewModel():GetSequenceList())
	end
	self.Owner:SetNWBool("IsSpoolin", false)

end


function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if self.Owner:IsSprinting() then return end
	if self.Owner:GetNWBool("IsSpoolin") == false then return end
	self:EmitSound( self.Weapon.Primary.Sound )

	self:ShootBullet( self.Primary.Damage, 1, self.Primary.Cone )
	self:TakePrimaryAmmo( 1 )

	
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon.Primary.Delay)
end


function SWEP:SecondaryAttack()

	if not IsFirstTimePredicted() then return end
	if CurTime() < reloaddelay then return end
	
	if self.Owner:GetNWBool("IsSpoolin") == false and CurTime() > spooldelay then
		spooldelay = CurTime() + 0.5
		self.Owner:SetNWBool("IsSpoolin", true)
		print("Spoolin")

		self.Owner:GetViewModel():SetSequence(2)

	elseif self.Owner:GetNWBool("IsSpoolin") == true and CurTime() > spooldelay then
		spooldelay = CurTime() + 0.5
		self.Owner:SetNWBool("IsSpoolin", false)
		print("Spoolin down")

		self.Owner:GetViewModel():SetSequence(3)

	end
	
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
	self:SetNextSecondaryFire(CurTime() + 0.5)
end

