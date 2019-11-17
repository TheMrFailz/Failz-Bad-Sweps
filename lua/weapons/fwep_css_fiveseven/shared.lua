SWEP.PrintName			= "FiveSeven" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = true
SWEP.Base			= "fwep_css_revolver"
SWEP.Category	= "FSweps"

SWEP.Primary.Damage			= 26
SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "Pistol"
SWEP.Primary.Delay			= 0.08
SWEP.Primary.Sound			= "weapons/fiveseven/fiveseven-1.wav"
SWEP.Primary.Cone			= 0.025

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.01
SWEP.Secondary.FOV			= 25

SWEP.BulletForce = 0.25


SWEP.HoldType				= "pistol"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 0.5

local reloaddelay = 0

SWEP.SwayScale = 0.5
SWEP.BobScale = 0.8

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0



-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector( -5.95,0,2.76)
SWEP.IronSightsAng = Vector( 0,0,0) 

SWEP.SprintGunPos = Vector(2,-15,-9)
SWEP.SprintGunAng = Vector(45,0,0)

SWEP.IdleGunPos = Vector(0,0,0)
SWEP.IdleGunAng = Vector(0,0,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.025
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.025

