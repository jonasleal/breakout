local physics = require("physics")
local tijolo = require("tijolo")
local bola = require("bola")
local cenario = {}
cenario.tijolos = {}
cenario.bola = {}

function construirCenario()
	local paredeTop = display.newRect(display.contentCenterX, 30 , display.contentWidth, 2)
	physics.addBody(paredeTop , "static")
	local paredeEsq = display.newRect(0, display.contentCenterY +30 , 2, display.contentHeight)
	physics.addBody(paredeEsq , "static")
	local paredeDir = display.newRect(display.contentWidth, display.contentCenterY +30 , 2, display.contentHeight)
	physics.addBody(paredeDir , "static")
	local paredeBai = display.newRect(display.contentCenterX,display.contentHeight +30,display.contentWidth,2)
	physics.addBody(paredeBai, "static")
	paredeBai:addEventListener("postCollision", colisaoFimDeJogo)

end

function cenario:iniciarNovaPartido( vidas, pontuacao )
	cenario.pontuacao = pontuacao
	cenario.vidas = vidas
	for i=#cenario.tijolos,1, -1 do
		if cenario.tijolos[i].view ~= nil then
			cenario.tijolos[i].view:removeSelf()
			table.remove(cenario.tijolos, i)
		end
	end
	cenario.bola.view = nil
	proximaPartida()
end

function proximaPartida()

	if(cenario.bola.view ~= nil)then
		for k, v in pairs(cenario.bola.view) do
			print(k) print(v)
		end
		cenario.bola.view:removeSelf()
	end
	colocarTijolos()
	criarBola(display.contentCenterX, display.contentHeight-15)
end

function criarBola(x , y )
	cenario.bola = bola:new(x, y)
	
end

function gameOverOnClick( event )
	if ( event.action == "clicked" ) then
        local i = event.index
        if ( i == 1 ) then
            print("SIM")
            cenario.vidas.text = 5
            cenario.pontuacao.text = 0
            cenario:iniciarNovaPartido(cenario.vidas, cenario.pontuacao)
        elseif ( i == 2 ) then
            print("NÂO")
        end
    end
end

function gameOver()
	native.showAlert( "GAME OVER", "Deseja reiniciar o jogo?", {"SIM", "NÂO"} , gameOverOnClick)
end

function colisaoFimDeJogo( event )
		local vidas = tonumber(cenario.vidas.text)
	if vidas > 0 then
		cenario.vidas.text = vidas - 1
		cenario.bola.view:removeSelf()
		cenario.bola.view = nil
		timer.performWithDelay(100,criarNovaBola)
	else
		cenario.bola.view:removeSelf()
		gameOver()
		print("GAME OVER")
	end
end
function criarNovaBola()
	cenario.bola = bola:new(display.contentCenterX, display.contentHeight-15)
end
function colisaoTijoloComum( event )

	for i=1,#cenario.tijolos do
		if cenario.tijolos[i].view == event.target then
			cenario.pontuacao.text = cenario.pontuacao.text +10
			event.target:removeSelf()
			table.remove(cenario.tijolos, i)
			break
		end
	end
	if #cenario.tijolos == 0 then
		timer.performWithDelay(100,proximaPartida)
	end

end

function colocarTijolos()
	local altura = display.contentHeight / 25
	local comprimento = display.contentWidth / 13
	for j=1,9 do
		for i=1,11 do
			local t = tijolo:new(display.newRect((comprimento + 2) * i , 
				50 + ((altura+2) * j )  , comprimento, altura), colisaoTijoloComum)
			table.insert(cenario.tijolos, t)
		end
	end
end

construirCenario()

return cenario