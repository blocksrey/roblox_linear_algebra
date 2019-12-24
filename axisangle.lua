local v3         = Vector3.new
local cf         = CFrame.new
local ncf        = cf()
local components = ncf.components
local acos       = math.acos

local axisangle = {}

function axisangle.matrix(m)
	local x, y, z, xx, yx, zx, xy, yy, zy, xz, yz, zz = components(m)
	local c = acos(1/2*(xx + yy + zz - 1))/((zy - yz)*(zy - yz) + (xz - zx)*(xz - zx) + (yx - xy)*(yx - xy))^(1/2)
	return v3(
		c*(zy - yz),
		c*(xz - zx),
		c*(yx - xy)
	)
end

return axisangle