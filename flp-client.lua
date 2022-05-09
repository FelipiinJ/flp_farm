-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
flP = Tunnel.getInterface("flp_farm")
local config = module("flp_farm","flp-config")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local rota = {}
local tipo = nil
local texto = nil
local cds = nil
local facs = nil
local mensagem = nil
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR FARM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local felipiin = 1000
        local ped = PlayerPedId()
        local coordenada = GetEntityCoords(ped)
		local teste = co
        
        for k,v in pairs(config.facs) do
            if not servico then
				local cds = config.facs[k].cds
				local texto = config.facs[k].texto
                local distance = #(coordenada - cds)

				if distance <= 3 then
					felipiin = 5
					DrawMarker(3,cds[1],cds[2],cds[3]- 0.6, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 255, 0, 0, 50, 0, 0, 0, 1)
					if distance <= 1.2 then
						felipiin = 5
						if config.draw3d then
							draw3DText(cds[1],cds[2],cds[3], texto)
							if IsControlJustPressed(0, 38) and flP.checkPermission(v.perm) then
								selecionado = 1
								servico = true
								facs = k
								rota = config.facs[k].rota
								tipo = v.tipo
								mensagem = v.mensagem
								blockService()
								CriandoBlip(rota,selecionado,"Rota de Coleta")
								TriggerEvent("Notify", "sucesso", "Você entrou em Serviço.")
							end
						end
					end
				end
			end
		end
		Citizen.Wait(felipiin)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS FARM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local felipiin = 1000
		if servico then
			local ped = PlayerPedId()
			local coordenada = GetEntityCoords(ped)
			local distance = #(coordenada - vec3(rota[selecionado].coords[1],rota[selecionado].coords[2],rota[selecionado].coords[3]))

			if distance <= 10 then
				felipiin = 5
				DrawMarker(3,rota[selecionado].coords[1],rota[selecionado].coords[2],rota[selecionado].coords[3]- 0.6, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 255, 81, 0, 50, 0, 0, 0, 1)
				if distance <= 1.2 then
					felipiin = 5
					drawTxt("PRESSIONE  ~r~E~w~  PARA "..mensagem.."", 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
					if IsControlJustPressed(0, 38) and not IsPedInAnyVehicle(ped) then
						vRP._playAnim(false,{{"mp_common","givetake1_a"}},true)
						processo = true
                        TriggerEvent("cancelando", true)
						SetTimeout(2000, function()
                            TriggerEvent("cancelando", false)
							ClearPedTasks(GetPlayerPed(-1))
							RemoveBlip(blips)  
							flP.checkFlpPayment(tipo,facs)     
							if selecionado == #rota then
								selecionado = 1
							else
								selecionado = selecionado + 1
							end
							
							CriandoBlip(rota,selecionado,"Rota de Coleta") 
						end)
					end
				end
			end
		end
		Citizen.Wait(felipiin)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR SERVIÇO FARM
-----------------------------------------------------------------------------------------------------------------------------------------
function blockService()
    Citizen.CreateThread(function()
        while true do
            local felipiin = 1000

            if servico then    
                felipiin = 5
				drawTxt("~y~PRESSIONE ~r~F7 ~w~SE DESEJA FINALIZAR A ROTA",4,0.270,0.905,0.45,255,255,255,200)
				drawTxt("VA ATÉ O DESTINO PARA COLETAR OS ~r~COMPONENTES",4,0.270,0.93,0.45,255,255,255,200)

                if IsControlJustPressed(0, 168) and not IsPedInAnyVehicle(PlayerPedId()) then
                    selecionado = 0
					servico = false
					RemoveBlip(blips)  
                    TriggerEvent("Notify", "importante", "Você saiu de Serviço.")             
                end
            else
                break                
            end            
            Citizen.Wait(felipiin)
        end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO LAVAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local felipiin = 1000
        local ped = PlayerPedId()
        local coordenada = GetEntityCoords(ped)
        
        for k,v in pairs(config.lavagem) do
            local distance = #(coordenada - v.cds)

            if distance <= 3 then
                felipiin = 5
                DrawMarker(3,v.cds[1],v.cds[2],v.cds[3]- 0.6, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 255, 0, 0, 50, 0, 0, 0, 1)
                if distance <= 1.2 then
                    felipiin = 4
                    if config.draw3d then
                        draw3DText(v.cds[1],v.cds[2],v.cds[3], v.texto)

                        if IsControlJustPressed(0, 38) and flP.checkPermission(v.perm) and not IsPedInAnyVehicle(ped) then
                            facs = k
                            flP.lavFlpPayment(facs)
                        end
                    end
                end
            end
        end
		Citizen.Wait(felipiin)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text, font, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function draw3DText(x, y, z, text)
	local _, _x, _y = World3dToScreen2d(x, y, z)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 370
	DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

function CriandoBlip(rota,selecionado,texto)
	blips = AddBlipForCoord(rota[selecionado].coords[1],rota[selecionado].coords[2],rota[selecionado].coords[3])
	SetBlipSprite(blips, 1)
	SetBlipColour(blips, 5)
	SetBlipScale(blips, 0.4)
	SetBlipAsShortRange(blips, false)
	SetBlipRoute(blips, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(texto)
	EndTextCommandSetBlipName(blips)
end