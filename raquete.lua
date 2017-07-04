local physics = require("physics")
local raquete = {}


function raquete:new(desenho)
	raquete.view = desenho
	physics.addBody(raquete.view , "static")
	raquete.view:addEventListener("touch", onTouch)
	raquete.view.direcao = 0
	return nova

end

function onTouch(event)
	local target = event.target
	if "began" == event.phase then
		local parent = target.parent
		parent:insert( target )
		display.getCurrentStage():setFocus(target)
		target.isFocus = true
		target.x0 = event.x - target.x

	elseif target.isFocus then
		if "moved" == event.phase then
			
			raquete.view.direcao = event.x - target.x - target.x0
			
			target.x = event.x - target.x0
			
			elseif "ended" == event.phase or "cancelled" == event.phase then
			display.getCurrentStage():setFocus(nil)
			target.isFocus = false
			raquete.view.direcao = 0
 
		end
	end
	return true

end

return raquete