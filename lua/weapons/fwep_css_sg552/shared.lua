SWEP.PrintName			= "SG552" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = true
SWEP.Base			= "fwep_css_scout"
SWEP.Category	= "FSweps"

SWEP.Primary.Damage			= 32
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"
SWEP.Primary.Delay			= 0.085
SWEP.Primary.Sound			= "weapons/sg552/sg552-1.wav"
SWEP.Primary.Cone			= 0.039

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.01
SWEP.Secondary.FOV			= 20
SWEP.Secondary.Zoom			= 70 -- FOV you want in the optic

SWEP.BulletForce = 0.25

SWEP.HoldType				= "ar2"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_rif_sg552.mdl"
SWEP.WorldModel = "models/weapons/w_rif_sg552.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 0.7
SWEP.ZoomLevel = 5

SWEP.BulletForce = 0.3

local reloaddelay = 0

SWEP.SwayScale = 0.5
SWEP.BobScale = 0.8

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0

gunstringname = "fwep_css_sg552"

-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector(-7.86, -10, 2.599)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SprintGunPos = Vector(5,-13,-10)
SWEP.SprintGunAng = Vector(-20,50,-50)

SWEP.IdleGunPos = Vector(0,0,0)
SWEP.IdleGunAng = Vector(0,0,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.04
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.03
