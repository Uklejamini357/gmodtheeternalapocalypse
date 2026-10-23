--- util stuff


local math_abs = math.abs
local math_sin = math.sin

function math.abssin(num)
	return math_abs(math_sin(num))
end

function math.abssinpos(num)
	return 0.5 + math_sin(num)/2
end
