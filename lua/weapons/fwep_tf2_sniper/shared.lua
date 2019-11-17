SWEP.PrintName			= "Scout" 
SWEP.Author			= "" -- 
SWEP.Instructions		= "Mouse 1 to pew pew, mouse 2 to zoom zoom."
SWEP.Spawnable = true
SWEP.Base			= "fwep_css_revolver"
SWEP.Category	= "FSweps [TF2]"

SWEP.Primary.Damage			= 50
SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "357"
SWEP.Primary.Delay			= 1.5
SWEP.Primary.Sound			= "weapons/sniper_shoot.wav"
SWEP.Primary.Cone			= 0.03

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.3
SWEP.AimDelay 				= 0.3
SWEP.Secondary.Cone			= 0.0
SWEP.Secondary.FOV			= 20

SWEP.HoldType				= "ar2"
SWEP.Weight = 1
SWEP.Slot = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/v_models/v_sniperrifle_sniper.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_sniperrifle.mdl"

SWEP.AllowSprintAng = true
SWEP.ViewKick = 1
SWEP.ZoomLevel = 3

local reloaddelay = 0

SWEP.SwayScale = 1
SWEP.BobScale = 2

local AmAimingGood = false 
local aimit = 0.01
local aimingtimer = 0

local chargeup = 0
local maxcharge = 0

gunstringname = "fwep_css_scout"

-- Adjust these variables to move the viewmodel's position
SWEP.IronSightsPos = Vector( -8.93, -1, 1.35 )
SWEP.IronSightsAng = Vector( 1, 0, -4.5 ) 

SWEP.SprintGunPos = Vector(10,-10,-10)
SWEP.SprintGunAng = Vector(-20,45,-40)

SWEP.IdleGunPos = Vector(0,0,0)
SWEP.IdleGunAng = Vector(0,0,0)

SWEP.CurrentGunPos = Vector(0,0,0)
SWEP.CurrentGunAng = Vector(0,0,0)

local iteratorthing = 0
SWEP.modifier = 0.05
local iteratorthing2 = 0
SWEP.sprintmodifier = 0.03

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self.Owner:SetNWBool("isaiming", false)
	self.Owner:SetNWFloat("chargeupsniper", 0)
	self.BobScaleBackup = self.BobScale
	if CLIENT then
		self.Weapon:ScopeThing()
		self.Weapon.RenderTarget = GetRenderTarget("ScopeDrawPlease2", ScrW( ), ScrH( ), false)

		custommat2 = Material( "models/weapons/v_sniperrifle/v_sniperrifle_scope"  )

		local texture_matrix = custommat2:GetMatrix("$basetexturetransform")

		texture_matrix:SetAngles(Angle(0, 0, 0)) 
		texture_matrix:SetScale(Vector(2, 1, 1)) 
		--texture_matrix:SetTranslation(Vector(1000,0,0))

		custommat2:SetMatrix("$basetexturetransform", texture_matrix)

		custommat2:SetUndefined("$envmap")
		
		
		
		custommat2:SetTexture("$basetexture", self.Weapon.RenderTarget)

		

		--custommat2:SetString("$translucent", "1")
		--custommat2:SetString("$alpha", 100)
		--custommat2:SetString("$basetexturetransform","center .5 .5 scale -1 1 rotate 40 translate 0 0")
	end
end

function SWEP:TranslateFOV( fov )

	if self.Owner:GetNWBool("isaiming") == true then
		return fov - (self.Secondary.FOV * (1 - iteratorthing))
	else
		return fov - (self.Secondary.FOV * (1 - iteratorthing))
	end
	
	
end

function SWEP:Reload()
	if CurTime() < reloaddelay then return end
	if self.Weapon:Clip1() == self.Weapon.Primary.DefaultClip then return end
	if not IsFirstTimePredicted() then return end
	
	if self.Owner:GetAmmoCount(self.Weapon.Primary.Ammo) - (self.Weapon.Primary.DefaultClip - self.Weapon:Clip1()) >= 0 then
		
		self.Owner:SetAmmo(self.Owner:GetAmmoCount(self.Weapon.Primary.Ammo) - (self.Weapon.Primary.DefaultClip - self.Weapon:Clip1()),self.Weapon.Primary.Ammo)
		self.Weapon:SetClip1(self.Weapon.Primary.DefaultClip)
	elseif self.Owner:GetAmmoCount(self.Weapon.Primary.Ammo) != 0 then
		
		self.Weapon:SetClip1(self.Weapon:Clip1() + self.Owner:GetAmmoCount(self.Weapon.Primary.Ammo))
		self.Owner:SetAmmo(0,self.Weapon.Primary.Ammo)
	else
		return
	end
	self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )

	if CLIENT then
		--self.Owner:GetViewModel():SetAnimTime(CurTime() + 100)
		
	end
	--self.Owner:GetViewModel():SetPlaybackRate(0.1)
	self.Owner:SetAnimation(PLAYER_RELOAD)
	
	reloaddelay = CurTime() + 0.1
	
	
	
	self:SetNextPrimaryFire(CurTime() +  0.1)
	self:SetNextSecondaryFire(CurTime() + 0.1)
end


function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end
	if CurTime() < reloaddelay then return end

	if self.Owner:GetNWBool("isaiming") == true then
		aimingtimer = CurTime() + self.AimDelay
		self.Owner:SetNWBool("isaiming", false)
		maxcharge = 0
		chargeup = 0

	elseif self.Owner:GetNWBool("isaiming") == false then
		aimingtimer = CurTime() + self.AimDelay
		self.Owner:SetNWBool("isaiming", true)
		maxcharge = CurTime() + 3.3
		chargeup = 0
	end


	self:SetNextSecondaryFire(CurTime() + self.Weapon.Secondary.Delay)
end


function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if self.Owner:IsSprinting() and not self.Owner:GetNWBool("isaiming") then return end
	self:EmitSound( self.Weapon.Primary.Sound )

	if self.Owner:GetNWBool("isaiming") == true then
		self:ShootBullet( self.Primary.Damage + 10 * chargeup, 1, self.Secondary.Cone )
		maxcharge = CurTime() + 3.3
	else
		self:ShootBullet( self.Primary.Damage, 1, self.Primary.Cone )
	end
	self:TakePrimaryAmmo( 1 )

	self.Owner:ViewPunch( Angle( -self.Weapon.ViewKick, 0, 0 ) )
	
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon.Primary.Delay)
end

local heightmodifier = 0

function SWEP:Think()

	if self.Owner:Crouching() == true then
		heightmodifier = 32
	else
		heightmodifier = 64
	end

	if CurTime() <= maxcharge and chargeup < 10 then
		chargeup = 10 - ((maxcharge - CurTime()) * 3.03)
		self.Owner:SetNWFloat("chargeupsniper", chargeup)
		--print(chargeup)
	end

	if CLIENT then

		if self.Owner == nil then return end

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

if CLIENT then

function SWEP:AdjustMouseSensitivity()
	if self.Owner:GetNWBool("isaiming") then
		return 0.3
	else
		return 1
	end

end


local scopereticlethick = 20




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
		origin = LocalPlayer():GetPos() + Vector(0,0,heightmodifier),
		angles = LocalPlayer():EyeAngles() + Angle(0,0,0), --Angle(LocalPlayer():EyeAngles().Pitch, LocalPlayer():EyeAngles().Yaw + 0, LocalPlayer():EyeAngles().Roll),
		x = 0, y = 0,
		w = ScrW(), h = ScrH(),
		drawviewmodel = false,
		drawhud = false,
		aspectratio = 1,
		fov = self.Weapon.ZoomLevel
		} )
		
		surface.SetDrawColor(0,0,0,200)
		surface.DrawRect(ScrW()/2,ScrH()/2, scopereticlethick, ScrH()/2)
		surface.DrawRect((ScrW()/2) + 100,ScrH()/2, ScrW()/2, scopereticlethick - 10)
		surface.DrawRect(0,ScrH()/2, (ScrW()/2) - 100, scopereticlethick - 10)
		surface.SetDrawColor(255,223,0,100)
		surface.DrawRect(ScrW() / 2 + 100, ScrH() / 2 + 50, self.Owner:GetNWFloat("chargeupsniper") * 30, 50)
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


