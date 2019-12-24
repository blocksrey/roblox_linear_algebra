local cf  = CFrame.new
local ncf = cf()
local faa = CFrame.fromAxisAngle

local cframe = {}

function cframe.axisangle(v)
	local m = v.Magnitude
	return m > 0 and faa(v, m) or ncf
end

function cframe.quaternion(q)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	return cframe(x, y, z, w)
end

return cframe