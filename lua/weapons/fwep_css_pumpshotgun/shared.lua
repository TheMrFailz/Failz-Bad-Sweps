SWEP.PrintName			= "Pump Shotgun" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = true
SWEP.Base			= "fwep_css_revolver"
SWEP.Category	= "FSweps"

SWEP.Primary.Damage			= 10
SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "Buckshot"
SWEP.Primary.Delay			= 0.85
SWEP.Primary.Sound			= "weapons/m3/m3-1.wav"
SWEP.Primary.Cone			= 0.06
SWEP.Primary.Pellets 		= 10

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.025
SWEP.Secondary.FOV			= 5

SWEP.BulletForce = 0.25

SWEP.HoldType				= "shotgun"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel = "models/weapons/w_shot_m3super90.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 1

SWEP.ReloadTime				= 0.5
SWEP.ReloadByRound			= true

local reloaddelay = 0

SWEP.SwayScale = 0.5
SWEP.BobScale = 0.8

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0



-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector( -7.65, -15, 2.9 )
SWEP.IronSightsAng = Vector( 1, 0, -0.5 ) 

SWEP.SprintGunPos = Vector(-05,-20,-20)
SWEP.SprintGunAng = Vector(50,70,-10)

SWEP.IdleGunPos = Vector(0,0,0)
SWEP.IdleGunAng = Vector(0,0,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.03
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.04


function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if self.Owner:IsSprinting() and not self.Owner:GetNWBool("isaiming") then return end
	self:EmitSound( self.Weapon.Primary.Sound )

	if self.Owner:GetNWBool("isaiming") == true then
		self:ShootBullet( self.Primary.Damage, self.Primary.Pellets, self.Secondary.Cone )
	else
		self:ShootBullet( self.Primary.Damage, self.Primary.Pellets, self.Primary.Cone )
	end
	self:TakePrimaryAmmo( 1 )

	self.Owner:ViewPunch( Angle( -self.Weapon.ViewKick, 0, 0 ) )
	
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon.Primary.Delay)
end

function SWEP:Reload()
	if self.Weapon:GetNetworkedBool( "reloading", false ) then return end
	
	if self.Zoomed then return false end

	if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
		if SERVER then
			self.Weapon:SetNetworkedBool( "reloading", true )
			timer.Simple(self.ReloadTime, function() self:ReloadShell() end)
			self.Owner:DoReloadEvent()
		end

		//print("do shotgun reload!")
		
		self.Weapon:SetNetworkedBool( "reloading", true )
		//self.Weapon:SetVar( "reloadtimer", CurTime() + self.ReloadTime )
		self.Owner:DoReloadEvent()
		self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
		
		self.Inaccuracy = self.MaxInaccuracy
	end
end


function SWEP:ReloadShell()
	if not self.Weapon:GetNetworkedBool( "reloading", false ) then return end
	
	if self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 then
		self.Weapon:SetNetworkedBool( "reloading", false )
		self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
		self.Owner:DoReloadEvent()
		self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return
	end

	timer.Simple(self.ReloadTime, function() self:ReloadShell() end)
	self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
	self.Owner:DoReloadEvent()

	if SERVER then
		self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
		self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
	end
end