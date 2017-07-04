local physics = require("physics")
local bola = {}

function bola:new(x , y)
	
	
	bola.view = display.newCircle( x , y, 7 )
	physics.addBody(bola.view , "dynamic", { bounce  = 1, radius = 7})
	bola.view:addEventListener("preCollision", onCollision)
	bola.view.isFixedRotation = true
	bola:iniciaMovimento(bola.view)
	return bola
end

function bola:iniciaMovimento(imagem)
	local vx = -110
	local vy = -200
	imagem:setLinearVelocity(vx, vy )
end

function onCollision( event )
		-- print(#cenario.tijolos)
		
		-- if event.target.remover then
		-- 	event.target:removeSelf()
		-- 	return
		-- end

		local vx, vy = event.target:getLinearVelocity()
		local vyMin = 100 vyMax = 500 
		local vxMin = 50 vxMax = 250

		if vy < 0 then
			if vy > -vyMin then
				print("vyMin: " .. vy .. " -20 " .. vy-20)
				vy = vy-20

			elseif vy <= -vyMax then
				print("vyMax: " .. vy .. " +20 " .. vy+20)
				vy = vy+20
			end
		elseif vy > 0 then
			if vy < vyMin then
				print("vyMin: " .. vy .. " +20 " .. vy+20)
				vy = vy+20
			elseif  vy >= vyMax then
				print("vyMax: " .. vy .. " -20 " .. vy-20)
				vy = vy-20
			end
		else
			vy = vy+20
		end
		
		if vx < 0 then
			if vx > -vxMin then
				print("vxMin: " .. vx .. " -10 " .. vx-10)
				vx = vx-10
			elseif vx <= -vxMax then
				print("vxMax: " .. vx .. " +10 " .. vx+10)
				vx = vx+10
			end
		elseif vx > 0 then
			if vx < vxMin then
				print("vxMin: " .. vx .. " +10 " .. vx+10)
				vx = vx+10
			elseif  vx >= vxMax then
				print("vxMax: " .. vx .. " -10 " .. vx-10)
				vx = vx-10
			end
		else
			vx = vx-20
		end

		
		local bonus = 0
		if event.other.direcao then
			if event.other.direcao < 0 then
				bonus = event.other.direcao * -1
			else
				bonus = event.other.direcao
			end

		if event.other.direcao < 0 and vx > 0 or vx < 0 and event.other.direcao > 0 then
			print("-----------------")
			print("Reduz ".. bonus .. "%")
			print("VX: ".. vx)
			vx = vx - (vx * (bonus/100))
			print("VX: ".. vx)
			print("-----------------")
			
		elseif event.other.direcao > 0 and vx > 0 or vx < 0 and event.other.direcao < 0 then
			print("-----------------") 
			print("Acelera ".. bonus .. "%")
			print("VX: ".. vx)
			vx = vx + (vx * (bonus/100))
			print("VX: ".. vx)
			print("-----------------")
		end
		end

		event.target:setLinearVelocity(vx, vy)
end
return bola