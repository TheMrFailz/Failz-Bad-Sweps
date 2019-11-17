SWEP.PrintName			= "Big Iron" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "UNLIMITED POWAAAA!"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Base			= "fwep_css_revolver"
SWEP.Category	= "FSweps"

SWEP.Primary.Damage			= 1000000
SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "357"
SWEP.Primary.Delay			= 0.65
SWEP.Primary.Sound			= "weapons/awp/awp1.wav"
SWEP.Primary.Cone			= 0.045

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.01
SWEP.Secondary.FOV			= 10 -- This adjusts FOV by this value, not set (Don't make this like 60, make it like 20)

SWEP.HoldType				= "revolver"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.BulletForce = 10000


SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 15

local reloaddelay = 0

SWEP.SwayScale = 3
SWEP.BobScale = 3

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0

-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector( -4.65, -6, 0.4 )
SWEP.IronSightsAng = Vector( 0.3, -0.1, 1.5 ) 

SWEP.SprintGunPos = Vector(0,0,-10)
SWEP.SprintGunAng = Vector(30,-20,-5)

SWEP.IdleGunPos = Vector(0,0,-3)
SWEP.IdleGunAng = Vector(-5,-3,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.04
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.04

local BigIronBase = nil

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self.Owner:SetNWBool("isaiming", false)
	self.BobScaleBackup = self.BobScale

	BigIronBase = CreateSound(self.Owner, "weapons/fwep_bigiron/bigiron.mp3")
	BigIronBase:Stop()

	if BigIronBase != nil then
		BigIronBase:Play()
	end
end


function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if self.Owner:IsSprinting() and not self.Owner:GetNWBool("isaiming") then return end
	
	self.Owner:EmitSound( "weapons/fwep_bigiron/bigiron_earrape.wav" )
	self:EmitSound( self.Weapon.Primary.Sound )
	if self.Owner:GetNWBool("isaiming") == true then
		self:ShootBullet( self.Primary.Damage, 1, self.Secondary.Cone )
	else
		self:ShootBullet( self.Primary.Damage, 1, self.Primary.Cone )
	end
	self:TakePrimaryAmmo( 1 )

	self.Owner:ViewPunch( Angle( -self.Weapon.ViewKick, 0, 0 ) )
	
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon.Primary.Delay)
end

function SWEP:Deploy()
	if BigIronBase != nil then
		BigIronBase:Play()
	end 

end

function SWEP:Holster(wep)
	if BigIronBase != nil then
		BigIronBase:Stop()
	end
	return true 
end

function SWEP:OnRemove()
	if BigIronBase != nil then
		BigIronBase:Stop()
	end
end

