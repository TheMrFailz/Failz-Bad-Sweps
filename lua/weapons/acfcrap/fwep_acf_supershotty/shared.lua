	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "pistol"

if (CLIENT) then
	
	SWEP.PrintName			= "Supa Shotty"
	SWEP.Author				= "Failz"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 3
	SWEP.IconLetter			= "f"
	SWEP.DrawCrosshair		= false
	SWEP.Purpose		= "Shoots many significantly big bullets."
	SWEP.Instructions       = ""

end

-- Use this swep as your base for new shotguns

util.PrecacheSound( "weapons/launcher_fire.wav" )

SWEP.Base				= "fwep_acf_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "FACF"
SWEP.ViewModel 			= "models/weapons/cstrike/c_shot_m3super90.mdl";
SWEP.WorldModel 		= "models/weapons/w_shot_m3super90.mdl";
SWEP.ViewModelFlip		= false
SWEP.UseHands = true

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Recoil			= 4
SWEP.Primary.ClipSize		= 8
SWEP.Primary.Delay			= 0.9
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"
SWEP.Primary.Sound 			= "weapons/m3/m3-1.wav"

SWEP.Primary.Pellets 		= 10

SWEP.ReloadTime				= 0.7
SWEP.ReloadByRound			= true

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.AimOffset = Vector(18, 10, -4)

SWEP.ScopeChopPos = false
SWEP.ScopeChopAngle = false
SWEP.WeaponBone = false

SWEP.IronSights = true
SWEP.IronSightsPos = Vector(-6.571, 7.65, 1.0)
SWEP.ZoomPos = Vector(2,-2,2)
SWEP.IronSightsAng = Angle(-3, 0, 0)

--[[
SWEP.IronSightsPos = Vector(-2, -4.74, 2.98)
SWEP.ZoomPos = Vector(2,-2,2)
SWEP.IronSightsAng = Angle(0.45, 0, 0)

]]

--SWEP.IronSightsPos = Vector(-6.571, -13.301, 2.279)
--SWEP.IronSightsAng = Vector(2.997, 0.1, 0)

SWEP.MinInaccuracy = 0
SWEP.MaxInaccuracy = 0
SWEP.Inaccuracy = SWEP.MaxInaccuracy
SWEP.InaccuracyDecay = 0.15
SWEP.AccuracyDecay = 0.25
SWEP.InaccuracyPerShot = 3
SWEP.InaccuracyCrouchBonus = 1.3
SWEP.InaccuracyDuckPenalty = 2

SWEP.Stamina = 1
SWEP.StaminaDrain = 0.004 / 1
SWEP.StaminaJumpDrain = 0.06

SWEP.HasZoom = true
SWEP.ZoomInaccuracyMod = 0.6
SWEP.ZoomDecayMod = 1.3
SWEP.ZoomFOV = 70

SWEP.Class = "MG"
SWEP.FlashClass = "MG"
SWEP.Launcher = false

SWEP.RecoilScale = 0.2
SWEP.RecoilDamping = 0.3

SWEP.ShotSpread = 3

function SWEP:InitBulletData()

	self.BulletData = {}


	self.BulletData["BoomPower"]			= 0.0047557539540155
	self.BulletData["Caliber"]			= 0.762

	self.BulletData["DragCoef"]			= 0.0027221994813961

	self.BulletData["FrAera"]			= 1.6513035
	self.BulletData["Id"]			= "7.62mmMG"
	self.BulletData["KETransfert"]			= 0.1
	self.BulletData["LimitVel"]			= 1800
	self.BulletData["MuzzleVel"]			= 405.75684870795
	self.BulletData["PenAera"]			= 1.5316264800639

	self.BulletData["ProjLength"]			= 4.6500000953674
	self.BulletData["ProjMass"]			= 0.060660635316597
	self.BulletData["PropLength"]			= 1.7999999523163
	self.BulletData["PropMass"]			= 0.0047557539540155
	self.BulletData["Ricochet"]			= 75
	self.BulletData["RoundVolume"]			= 10.65090765374
	self.BulletData["ShovePower"]			= 0
	self.BulletData["Tracer"]			= 0
	self.BulletData["Type"]			= "AP"
	self.BulletData["InvalidateTraceback"]			= true

end

function SWEP:FireBullet()

	self.Owner:LagCompensation( true )

	local MuzzlePos = self.Owner:GetShootPos()
	local MuzzleVec = self.Owner:GetAimVector()
	local angs = self.Owner:EyeAngles()	
	local MuzzlePos2 = MuzzlePos + angs:Forward() * self.AimOffset.x + angs:Right() * self.AimOffset.y
	local MuzzleVecFinal = self:inaccuracy(MuzzleVec, self.Inaccuracy)
	
	self.BulletData["Pos"] = MuzzlePos
	self.BulletData["Owner"] = self.Owner
	self.BulletData["Gun"] = self
	
	local plyvel = self.Owner:GetVelocity()
	for i=1, self.Primary.Pellets do
		self.BulletData["Flight"] = self:inaccuracy(MuzzleVecFinal, self.ShotSpread) * self.BulletData["MuzzleVel"] * 39.37 + plyvel + MuzzleVecFinal * 16
			
		ACF_CreateBulletSWEP(self.BulletData, self, true)
	end
	
	self:MuzzleEffect( MuzzlePos2 , MuzzleVec )
	
	self.Owner:LagCompensation( false )
	
	//debugoverlay.Line(MuzzlePos, MuzzlePos + MuzzleVecFinal * 10000, 60, Color(200, 200, 255, 255),  true)
	
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