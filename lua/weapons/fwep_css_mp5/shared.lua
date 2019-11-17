SWEP.PrintName			= "MP5" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = true
SWEP.Base			= "fwep_css_revolver"
SWEP.Category	= "FSweps"

SWEP.Primary.Damage			= 23
SWEP.Primary.ClipSize		= 45
SWEP.Primary.DefaultClip	= 45
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"
SWEP.Primary.Delay			= 0.065
SWEP.Primary.Sound			= "weapons/mp5navy/mp5-1.wav"
SWEP.Primary.Cone			= 0.03

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.02
SWEP.Secondary.FOV			= 20

SWEP.HoldType				= "ar2"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 0.25

local reloaddelay = 0

SWEP.SwayScale = 0.5
SWEP.BobScale = 0.8

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0



-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector(-5.321, -10.702, 2.079)
SWEP.IronSightsAng = Vector(1.1, 0.04, 0)

SWEP.SprintGunPos = Vector(-05,-20,-20)
SWEP.SprintGunAng = Vector(50,70,-10)

SWEP.IdleGunPos = Vector(0,0,0)
SWEP.IdleGunAng = Vector(0,0,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.025
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.015

