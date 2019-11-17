SWEP.PrintName			= "Galil" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = true
SWEP.Base			= "fwep_css_revolver"
SWEP.Category	= "FSweps"

SWEP.Primary.Damage			= 30
SWEP.Primary.ClipSize		= 35
SWEP.Primary.DefaultClip	= 35
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"
SWEP.Primary.Delay			= 0.1
SWEP.Primary.Sound			= "weapons/galil/galil-1.wav"
SWEP.Primary.Cone			= 0.045

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.018
SWEP.Secondary.FOV			= 20

SWEP.HoldType				= "ar2"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 0.35

local reloaddelay = 0

SWEP.SwayScale = 1.5
SWEP.BobScale = 1.5

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0



-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector( -6.37,-6,2.5 )
SWEP.IronSightsAng = Vector( 0,0,0 ) 

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

