SWEP.PrintName			= "P90" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = true
SWEP.Base			= "fwep_css_revolver"
SWEP.Category	= "FSweps"

SWEP.Primary.Damage			= 25
SWEP.Primary.ClipSize		= 50
SWEP.Primary.DefaultClip	= 50
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"
SWEP.Primary.Delay			= 0.06
SWEP.Primary.Sound			= "weapons/p90/p90-1.wav"
SWEP.Primary.Cone			= 0.03

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.01
SWEP.Secondary.FOV			= 30
SWEP.Secondary.Zoom			= 40 -- FOV you want in the optic

SWEP.HoldType				= "smg"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/w_smg_p90.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 0.1
SWEP.ZoomLevel = 2

local reloaddelay = 0

SWEP.SwayScale = 0.5
SWEP.BobScale = 0.8

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0

gunstringname = "fwep_css_scout"

-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector( -5.72, -6, 1.7 )
SWEP.IronSightsAng = Vector( 2, 0, 0.2 ) 

SWEP.SprintGunPos = Vector(-05,-20,-20)
SWEP.SprintGunAng = Vector(50,70,-10)

SWEP.IdleGunPos = Vector(0,0,0)
SWEP.IdleGunAng = Vector(0,0,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.05
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.04

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self.Owner:SetNWBool("isaiming", false)
	self.BobScaleBackup = self.BobScale
	if CLIENT then
		self.Weapon:ScopeThing()
		self.Weapon.RenderTarget = GetRenderTarget("ScopeDrawPlease2", ScrW( ), ScrH( ), false)

		custommat3 = Material( "models/weapons/v_models/smg_p90/smg_p90_sight"  )

		local texture_matrix = custommat3:GetMatrix("$basetexturetransform")

		--texture_matrix:SetTranslation(Vector(0,100,0))
		texture_matrix:SetAngles(Angle(0, 0, 0)) 
		texture_matrix:SetScale(Vector(1, 1, 1)) 

		custommat3:SetMatrix("$basetexturetransform", texture_matrix)

		--custommat3:SetFloat("$selfillummaskscale", 10)
		
		
		
		custommat3:SetTexture("$basetexture", self.Weapon.RenderTarget)

		

		--custommat3:SetString("$translucent", "1")
		--custommat3:SetString("$alpha", 100)
		--custommat3:SetString("$basetexturetransform","center .5 .5 scale -1 1 rotate 40 translate 0 0")
	end
end

if CLIENT then

function SWEP:AdjustMouseSensitivity()
	if self.Owner:GetNWBool("isaiming") then
		return 0.3
	else
		return 1
	end

end


local scopereticlethick = 50



function SWEP:ScopeThing()

	local old
	
	old = render.GetRenderTarget( )
	
	render.SetRenderTarget( self.RenderTarget )
	render.SetViewPort( 0, 0, ScrW( ), ScrH( ) )
	render.Clear( 255, 255, 255, 0, true )
	
	local x, y = self:GetPos()

	local matr = Matrix()

	--matr:Scale(
	cam.Start2D( )
		render.RenderView( {
		origin = LocalPlayer():GetPos() + Vector(0,0,64),
		angles = LocalPlayer():EyeAngles() + Angle(0,0,0), --Angle(LocalPlayer():EyeAngles().Pitch, LocalPlayer():EyeAngles().Yaw + 0, LocalPlayer():EyeAngles().Roll),
		x = 0, y = 0,
		w = ScrW(), h = ScrH() - 400,
		drawviewmodel = false,
		drawhud = false,
		aspectratio = 1,
		fov = self.Weapon.ZoomLevel
		} )
		
		surface.SetDrawColor(255,0,0,255)
		surface.DrawRect(ScrW()/2,ScrH()/3, scopereticlethick, ScrH()/2)

	cam.End2D( )
	

	render.SetViewPort( 0, 0, ScrW( ), ScrH( ) )
	render.SetRenderTarget( old )
	
end



function paintthedamnscope(otherthing, ply, weaponent)
	--print(otherthing:GetClass())
	if weaponent:GetClass() == gunstringname then
		--otherthing:SetSubMaterial(0, "")
		--weaponent:DrawShadow(false)
	else
		--otherthing:SetSubMaterial(0,"")
		--otherthing:SetSubMaterial(1,"")
		--otherthing:SetSubMaterial(2,"")
	end
	
end
hook.Add("PostDrawViewModel", "FUCKINGPAINTIT", paintthedamnscope)


local delaytimerscope = 0.02
local delaytimerscopecounter = 0

function SWEP:DrawHUD() 	
	if delaytimerscopecounter <= CurTime() then
		self.Weapon:ScopeThing()
		delaytimerscopecounter = CurTime() + delaytimerscope
	end
end
--hook.Add("Think", "AAAAAAA", DrawCoolScope)



end


