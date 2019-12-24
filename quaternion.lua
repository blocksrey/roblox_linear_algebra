local cos        = math.cos
local sin        = math.sin
local acos       = math.acos
local cf         = CFrame.new
local ncf        = cf()
local components = ncf.components

local quaternion = {}

function quaternion.inv(q)
	return {q[1], -q[2], -q[3], -q[4]}
end

function quaternion.mul(a, b)
	local aw, ax, ay, az = a[1], a[2], a[3], a[4]
	local bw, bx, by, bz = b[1], b[2], b[3], b[4]
	return {
		aw*bw - ax*bx - ay*by - az*bz;
		aw*bx + ax*bw + ay*bz - az*by;
		aw*by - ax*bz + ay*bw + az*bx;
		aw*bz + ax*by - ay*bx + az*bw;
	}
end

function quaternion.pow(q, n)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	local t = n*acos(w)
	local s = sin(t)/(x*x + y*y + z*z)^(1/2)
	return {cos(t), s*x, s*y, s*z}
end

function quaternion.slerp(a, b, n)
	local aw, ax, ay, az = a[1], a[2], a[3], a[4]
	local bw, bx, by, bz = b[1], b[2], b[3], b[4]

	if aw*bw + ax*bx + ay*by + az*bz < 0 then
		aw = -aw
		ax = -ax
		ay = -ay
		az = -az
	end

	local w = aw*bw + ax*bx + ay*by + az*bz
	local x = aw*bx - ax*bw + ay*bz - az*by
	local y = aw*by - ax*bz - ay*bw + az*bx
	local z = aw*bz + ax*by - ay*bx - az*bw

	local t = n*acos(w)
	local s = sin(t)/(x*x + y*y + z*z)^(1/2)

	local bw = cos(t)
	local bx = s*x
	local by = s*y
	local bz = s*z

	return {
		aw*bw - ax*bx - ay*by - az*bz;
		aw*bx + ax*bw - ay*bz + az*by;
		aw*by + ax*bz + ay*bw - az*bx;
		aw*bz - ax*by + ay*bx + az*bw;
	}
end

function quaternion.axisangle(v)
	local x, y, z = v.x, v.y, v.z
	local l = (x*x + y*y + z*z)^(1/2)
	local x, y, z = x/l, y/l, z/l
	local s = sin(1/2*l)
	return {cos(1/2*l), s*x, s*y, s*z}
end

function quaternion.eulerx(t)
	return {cos(1/2*t), sin(1/2*t), 0, 0}
end

function quaternion.eulery(t)
	return {cos(1/2*t), 0, sin(1/2*t), 0}
end

function quaternion.eulerz(t)
	return {cos(1/2*t), 0, 0, sin(1/2*t)}
end

function quaternion.cframe(cf)
	local x, y, z, xx, yx, zx, xy, yy, zy, xz, yz, zz = components(cf)
	if xx + yy + zz > 0 then
		local s = 2*(1 + xx + yy + zz)^(1/2)
		return {1/4*s, (yz - zy)/s, (zx - xz)/s, (xy - yx)/s}
	elseif xx > yy and xx > zz then
		local s = 2*(1 + xx - yy - zz)^(1/2)
		return {(yz - zy)/s, 1/4*s, (yx + xy)/s, (zx + xz)/s}
	elseif yy > zz then
		local s = 2*(1 - xx + yy - zz)^(1/2)
		return {(zx - xz)/s, (yx + xy)/s, 1/4*s, (zy + yz)/s}
	else
		local s = 2*(1 - xx - yy + zz)^(1/2)
		return {(xy - yx)/s, (zx + xz)/s, (zy + yz)/s, 1/4*s}
	end
end

return quaternion