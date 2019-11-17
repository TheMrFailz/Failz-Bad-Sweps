include('shared.lua')
 
SWEP.PrintName          = "[TF2] Minigun"
SWEP.Slot               = 2
SWEP.SlotPos            = 1
SWEP.DrawAmmo           = true
SWEP.DrawCrosshair      = true


if CLIENT then
	local WorldModel = ClientsideModel( SWEP.WorldModel )

	-- Settings...
	WorldModel:SetSkin( 1 )
	WorldModel:SetNoDraw( true )
	WorldModel:SetModelScale(0.7,0)

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()

		if ( IsValid( _Owner ) ) then
			-- Specify a good position
			local offsetVec = Vector( -6, -3, 0 )
			local offsetAng = Angle( 177, -190, 0 )

			local boneid = _Owner:LookupBone( "ValveBiped.Bip01_R_Hand" ) -- Right Hand
			if !boneid then return end

			local matrix = _Owner:GetBoneMatrix( boneid )
			if !matrix then return end

			local newPos, newAng = LocalToWorld( offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles() )

			WorldModel:SetPos( newPos )
			WorldModel:SetAngles( newAng )

			WorldModel:SetupBones()
		else
			WorldModel:SetPos( self:GetPos() )
			WorldModel:SetAngles( self:GetAngles() )
		end

		WorldModel:DrawModel()
	end

end
