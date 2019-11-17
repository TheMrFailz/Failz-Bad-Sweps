SWEP.PrintName			= "AUG" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = true
SWEP.Base			= "fwep_css_scout"
SWEP.Category	= "FSweps"

SWEP.Primary.Damage			= 28
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"
SWEP.Primary.Delay			= 0.08
SWEP.Primary.Sound			= "weapons/aug/aug-1.wav"
SWEP.Primary.Cone			= 0.04

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.008
SWEP.Secondary.FOV			= 20
SWEP.Secondary.Zoom			= 40 -- FOV you want in the optic

SWEP.HoldType				= "ar2"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/w_rif_aug.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 1
SWEP.ZoomLevel = 5

local reloaddelay = 0

SWEP.SwayScale = 0.5
SWEP.BobScale = 0.8

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0

gunstringname = "fwep_css_aug"

-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector( -7.976,-6,1.91 )
SWEP.IronSightsAng = Vector( 1,-2.5,0 ) 

SWEP.SprintGunPos = Vector(5,-10,-10)
SWEP.SprintGunAng = Vector(-20,60,-50)

SWEP.IdleGunPos = Vector(0,0,0)
SWEP.IdleGunAng = Vector(0,0,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.04
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.03
