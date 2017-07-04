
local physics = require("physics")
physics:start()
physics.setGravity(0,0)
physics.setDrawMode( "hybrid" )
local raquete = require("raquete")
local cenario = require("cenarioView")
local novaRaquete
local pontuacao
local vidas

function carregarPartida()
	display.newText({text = "PONTUAÇÂO", x = display.contentWidth - 130, y = 10})
	display.newText({text = "VIDAS", x = 50, y = 10})
	pontuacao = display.newText({text = "0", x = display.contentWidth - 30, y = 10})
	vidas = display.newText({text = "5", x = 100, y = 10})
	novaRaquete = raquete:new(display.newRect(display.contentCenterX, display.contentHeight , 100, 10))
	cenario:iniciarNovaPartido( vidas, pontuacao )
	

end

carregarPartida()

