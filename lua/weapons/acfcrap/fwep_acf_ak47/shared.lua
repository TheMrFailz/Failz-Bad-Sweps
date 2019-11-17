	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "pistol"

if (CLIENT) then
	
	SWEP.PrintName			= "AKM"
	SWEP.Author				= "Failz"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 3
	SWEP.IconLetter			= "f"
	SWEP.DrawCrosshair		= false
	SWEP.Purpose		= "Shoots big bullets."
	SWEP.Instructions       = ""

end

util.PrecacheSound( "weapons/launcher_fire.wav" )

SWEP.Base				= "fwep_acf_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "FACF"
SWEP.ViewModel 			= "models/weapons/cstrike/c_rif_ak47.mdl";
SWEP.WorldModel 		= "models/weapons/w_rif_ak47.mdl";
SWEP.ViewModelFlip		= false
SWEP.UseHands = true

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Recoil			= 2
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= 120
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"
SWEP.Primary.Sound 			= "weapons/ak47/ak47-1.wav"

SWEP.ReloadTime				= 2.5

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.AimOffset = Vector(18, 10, -4)

SWEP.ScopeChopPos = false
SWEP.ScopeChopAngle = false
SWEP.WeaponBone = false

SWEP.IronSights = true
SWEP.IronSightsPos = Vector(-6.571, 6.55, 1.0)
SWEP.ZoomPos = Vector(2,-2,2)
SWEP.IronSightsAng = Angle(-3, 0, 0)

--[[
SWEP.IronSightsPos = Vector(-2, -4.74, 2.98)
SWEP.ZoomPos = Vector(2,-2,2)
SWEP.IronSightsAng = Angle(0.45, 0, 0)

]]

--SWEP.IronSightsPos = Vector(-6.571, -13.301, 2.279)
--SWEP.IronSightsAng = Vector(2.997, 0.1, 0)

SWEP.MinInaccuracy = 1
SWEP.MaxInaccuracy = 3
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


function SWEP:InitBulletData()

	self.BulletData = {}
	//*

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