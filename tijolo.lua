local physics = require("physics")
local tijolo = {}

function tijolo:new(desenho, onCollision)
	local novo = {}
	setmetatable(novo, {__index = tijolo})
	novo.view = desenho
	physics.addBody(novo.view , "static")
	novo.view:addEventListener("collision", onCollision)
	return novo
end



return tijolo