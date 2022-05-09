-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
flP = {}
Tunnel.bindInterface("flp_farm",flP)
local config = module("flp_farm","flp-config")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
local activeUser = {}
function flP.checkFlpPayment(tipo,facs)
	vRP.antiflood(source,'Farm',2)
	local source = source
	local user_id = vRP.getUserId(source)
	local itens = config.facs[facs].itens
	local tipo = config.facs[facs].tipo

	if user_id and activeUser[user_id] == nil then
		activeUser[user_id] = true
		for k,item in pairs(itens) do

			local quantidade = math.random(itens[k][2],itens[k][3])
			local pesoitem = vRP.getItemWeight(itens[k][1])*quantidade

			if tipo == tipo then
				if vRP.getInventoryWeight(user_id) + parseInt(pesoitem) <= vRP.getInventoryMaxWeight(user_id) then
					vRP.giveInventoryItem(user_id,itens[k][1],quantidade)
					TriggerClientEvent("Notify",source,"aviso","Você recebeu ".. quantidade .."x "..vRP.itemNameList(itens[k][1])..".",5000)
				else
					TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
				end
			end
		end
	end
	activeUser[user_id] = nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LAVAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
function flP.lavFlpPayment(facs)
    local source = source
	local user_id = vRP.getUserId(source)
	local porcentagem = config.lavagem[facs].porcentagem
	local item = config.lavagem[facs].item
	local valor = vRP.prompt(source,"Valor:","")

	if user_id then
		if valor == "" then
			return
		end
		local qtd = tonumber(valor)

		if qtd > 0 then
			if vRP.tryGetInventoryItem(user_id,item,qtd) then
				vRP.giveMoney(user_id,(qtd*porcentagem))
				TriggerClientEvent("Notify",source,"aviso","Você lavou ".. qtd .." em "..vRP.itemNameList(item)..".",5000)
			else
				TriggerClientEvent("Notify",source,"negado","Você não possui este dinheiro.") 
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function flP.checkPermission(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,perm)
end