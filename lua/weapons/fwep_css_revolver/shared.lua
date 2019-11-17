SWEP.PrintName			= "Revolver2" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = true
SWEP.Base			= "weapon_base"
SWEP.Category	= "FSweps"

SWEP.Primary.Damage			= 70
SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "357"
SWEP.Primary.Delay			= 0.75
SWEP.Primary.Sound			= "Weapon_357.Single"
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

SWEP.BulletForce = 0.25

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 5

local reloaddelay = 0

SWEP.SwayScale = 0.3
SWEP.BobScale = 0.3

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0

-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector( -4.65, -6, 0.4 )
SWEP.IronSightsAng = Vector( 0.3, -0.1, 1.5 ) 

SWEP.SprintGunPos = Vector(0,0,-10)
SWEP.SprintGunAng = Vector(30,-20,-5)

SWEP.IdleGunPos = Vector(0,0,0)
SWEP.IdleGunAng = Vector(0,0,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.04
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.04

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self.Owner:SetNWBool("isaiming", false)
	self.BobScaleBackup = self.BobScale
end

function SWEP:TranslateFOV( fov )

	if self.Owner:GetNWBool("isaiming") == true then
		return fov - (self.Secondary.FOV * (1 - iteratorthing))
	else
		return fov - (self.Secondary.FOV * (1 - iteratorthing))
	end
	
	
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if self.Owner:IsSprinting() and not self.Owner:GetNWBool("isaiming") then return end
	self:EmitSound( self.Weapon.Primary.Sound )

	if self.Owner:GetNWBool("isaiming") == true then
		self:ShootBullet( self.Primary.Damage, 1, self.Secondary.Cone, self.Primary.Ammo, self.BulletForce )
	else
		self:ShootBullet( self.Primary.Damage, 1, self.Primary.Cone, self.Primary.Ammo, self.BulletForce )
	end
	self:TakePrimaryAmmo( 1 )

	self.Owner:ViewPunch( Angle( -self.Weapon.ViewKick, 0, 0 ) )
	
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon.Primary.Delay)
end

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end
	--if CurTime() < reloaddelay then return end

	if self.Owner:GetNWBool("isaiming") == true then
		aimingtimer = CurTime() + self.AimDelay
		self.Owner:SetNWBool("isaiming", false)

	elseif self.Owner:GetNWBool("isaiming") == false then
		aimingtimer = CurTime() + self.AimDelay
		self.Owner:SetNWBool("isaiming", true)

	end


	self:SetNextSecondaryFire(CurTime() + self.Weapon.Secondary.Delay)
end

function SWEP:Reload()
	if CurTime() < reloaddelay then return end
	if self.Weapon:Clip1() == self.Weapon.Primary.ClipSize then return end
	if not IsFirstTimePredicted() then return end
	
	if self.Owner:GetNWBool("isaiming") == true then
		aimingtimer = CurTime() + self.AimDelay
		self.Owner:SetNWBool("isaiming", false)
	end

	if self.Owner:GetAmmoCount(self.Weapon.Primary.Ammo) - (self.Weapon.Primary.ClipSize - self.Weapon:Clip1()) >= 0 then
		
		self.Owner:SetAmmo(self.Owner:GetAmmoCount(self.Weapon.Primary.Ammo) - (self.Weapon.Primary.ClipSize - self.Weapon:Clip1()),self.Weapon.Primary.Ammo)
		self.Weapon:SetClip1(self.Weapon.Primary.ClipSize)
	elseif self.Owner:GetAmmoCount(self.Weapon.Primary.Ammo) != 0 then
		
		self.Weapon:SetClip1(self.Weapon:Clip1() + self.Owner:GetAmmoCount(self.Weapon.Primary.Ammo))
		self.Owner:SetAmmo(0,self.Weapon.Primary.Ammo)
	else
		return
	end
	self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )

	local reloadmodifier = 1

	self.Owner:GetViewModel():SetPlaybackRate( reloadmodifier )

	if CLIENT then
		--self.Owner:GetViewModel():SetAnimTime(CurTime() + 100)
		
	end
	--self.Owner:GetViewModel():SetPlaybackRate(0.1)
	self.Owner:SetAnimation(PLAYER_RELOAD)
	
	reloaddelay = CurTime() + (3.2 / reloadmodifier)
	
	
	
	self:SetNextPrimaryFire(CurTime() + (3.2 / reloadmodifier))
	self:SetNextSecondaryFire(CurTime() + (3.2 / reloadmodifier))
end



local heightmodifier = 0

function SWEP:Think()
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

function SWEP:GetViewModelPosition( EyePos, EyeAng )
	local Mul = 1.0

	local Offset = self.CurrentGunPos
	
	EyeAng = EyeAng * 1

	EyeAng:RotateAroundAxis( EyeAng:Right(), 	self.CurrentGunAng.x * Mul )
	EyeAng:RotateAroundAxis( EyeAng:Up(), 		self.CurrentGunAng.y * Mul )
	EyeAng:RotateAroundAxis( EyeAng:Forward(),	self.CurrentGunAng.z * Mul )



	local Right 	= EyeAng:Right()
	local Up 		= EyeAng:Up()
	local Forward 	= EyeAng:Forward()

	EyePos = EyePos + Offset.x * Right * Mul
	EyePos = EyePos + Offset.y * Forward * Mul
	EyePos = EyePos + Offset.z * Up * Mul

	return EyePos, EyeAng
end


