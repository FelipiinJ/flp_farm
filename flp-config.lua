config = {}
--------------------------------------------------------------------------------------------------------------------------------------------------
-- Texto 3d
--------------------------------------------------------------------------------------------------------------------------------------------------
config.draw3d = true -- Colocar false se quiser que desative o Texto 3d
--------------------------------------------------------------------------------------------------------------------------------------------------
-- Config para criar a Lavagem
--------------------------------------------------------------------------------------------------------------------------------------------------
config.lavagem = {
    ["Lavagem"] = { -- NOME DO QUE A FUNÇÃO FAZ
		cds = vec3(-2678.67,1332.87,140.87), -- COORDENADAS PARA LAVAR O DINHEIRO
		perm = "admin.perms", -- PERMISSAO PARA PODER INICIAR A LAVAGEM
		texto = "Pressione ~r~[E]~w~ para iniciar a Lavagem", -- TEXTO 3D QUE APARACERÁ
		item = "dinheirosujo", -- O ITEM QUE VAI SER USADO PARA TROCAR POR DINHEIRO NA LAVAGEM
		porcentagem = 0.9 -- PORCENTAGEM DE LAVAGEM 0.9 = 90%
	}
}
--------------------------------------------------------------------------------------------------------------------------------------------------
-- Farm com Permissáo Tipo e Rota
--------------------------------------------------------------------------------------------------------------------------------------------------
config.facs = {
    ["Cartel"] = { -- NOME DA FACÇÃO OU QUALQUER NOME QUE VAI INICIAR O FARM
		cds = vec3(-2676.75,1336.28,140.87), -- COORDENADAS PARA INICIAR A ROTA
		perm = "admin.perms", -- PERMISSAO PARA PODER INICIAR A ROTA
		tipo = "Arma", -- NOME DO SEU TIPO DE FARM EX = ARMA,MUNIÇÃO,COLETE ESSAS COISAS
		texto = "Pressione ~r~[E]~w~ para iniciar a Rota", -- TEXTO 3D QUE APARACERÁ
		mensagem = "COLETAR OS ~y~COMPONENTES~w~ DE ~r~ARMAS", -- MENSAGEM DE DRAWTEXT DE COLETAR OS COMPONENTES
		itens = { -- ITENS QUE A ROTA VAI ENTREGAR E A QUANTIDADE DE MINIMO A MAXIMO
			{"pecadearma", 3, 4},
			{"armacaodearma", 1, 2}
		},
        rota = { -- ROTA DE FARM
			[1]  = { coords = vec3(-3068.87,3328.0,8.8) },
	        [2]  = { coords = vec3(439.38,3561.53,33.24) },
	        [3]  = { coords = vec3(1601.67,3562.69,35.37) },
	        [4]  = { coords = vec3(1310.24,4386.92,41.23) },
	        [5]  = { coords = vec3(1943.85,4647.04,40.63) },
	        [6]  = { coords = vec3(1736.61,6423.25,34.39) },
	        [7]  = { coords = vec3(-758.16,5600.44,33.83) },
	        [8]  = { coords = vec3(264.26,3096.01,42.79) },
	        [9]  = { coords = vec3(2867.29,1506.66,24.57) },
	        [10]  = { coords = vec3(2544.2,377.0,108.62) },
	        [11]  = { coords = vec3(2505.42,-333.5,93.0) },
	        [12]  = { coords = vec3(1126.87,-1302.52,34.73) },
	        [13]  = { coords = vec3(-174.42,6548.54,11.14) },
	        [14]  = { coords = vec3(-2174.40,4287.76,49.08) },
	        [15]  = { coords = vec3(1738.06,3325.96,41.22) },
	        [16]  = { coords = vec3(1388.46,3612.56,38.94) },
	        [17]  = { coords = vec3(912.70,3555.37,33.86) },
	        [18]  = { coords = vec3(914.14,3657.31,32.50) },
	        [19]  = { coords = vec3(-1055.16,4921.26,211.81) },
	        [20]  = { coords = vec3(-1150.40,4940.95,222.26) },
	        [21]  = { coords = vec3(-2294.30,3191.87,32.81) },
	        [22]  = { coords = vec3(-2542.07,2300.32,33.21) },
	        [23]  = { coords = vec3(-3187.55,1050.45,20.88) },
	        [24]  = { coords = vec3(529.31,-1940.16,24.98) }
        }
	},
    ["Yakuza"] = { -- NOME DA FACÇÃO OU QUALQUER NOME QUE VAI INICIAR O FARM
		cds = vec3(-2675.63,1330.97,140.88), -- COORDENADAS PARA INICIAR A ROTA
		perm = "admin.perms", -- PERMISSAO PARA PODER INICIAR A ROTA
		tipo = "Colete", -- TIPO DE FARM QUE VAI INICIAR
		texto = "Pressione ~r~[E]~w~ para iniciar a Rota", -- TEXTO 3D QUE APARACERÁ
		mensagem = "COLETAR OS ~y~COMPONENTES~w~ DE ~r~COLETE", -- MENSAGEM DE DRAWTEXT DE COLETAR OS COMPONENTES
		itens = { -- ITENS QUE A ROTA VAI ENTREGAR E A QUANTIDADE DE MINIMO A MAXIMO
			{"linha", 3, 4},
			{"tecido", 1, 2}
		},
        rota = { -- ROTA DE FARM
            [1]  = { coords = vec3(-3068.87,3328.0,8.8) },
	        [2]  = { coords = vec3(439.38,3561.53,33.24) },
	        [3]  = { coords = vec3(1601.67,3562.69,35.37) },
	        [4]  = { coords = vec3(1310.24,4386.92,41.23) },
	        [5]  = { coords = vec3(1943.85,4647.04,40.63) },
	        [6]  = { coords = vec3(1736.61,6423.25,34.39) },
	        [7]  = { coords = vec3(-758.16,5600.44,33.83) },
	        [8]  = { coords = vec3(264.26,3096.01,42.79) },
	        [9]  = { coords = vec3(2867.29,1506.66,24.57) },
	        [10]  = { coords = vec3(2544.2,377.0,108.62) },
	        [11]  = { coords = vec3(2505.42,-333.5,93.0) },
	        [12]  = { coords = vec3(1126.87,-1302.52,34.73) },
	        [13]  = { coords = vec3(-174.42,6548.54,11.14) },
	        [14]  = { coords = vec3(-2174.40,4287.76,49.08) },
	        [15]  = { coords = vec3(1738.06,3325.96,41.22) },
	        [16]  = { coords = vec3(1388.46,3612.56,38.94) },
	        [17]  = { coords = vec3(912.70,3555.37,33.86) },
	        [18]  = { coords = vec3(914.14,3657.31,32.50) },
	        [19]  = { coords = vec3(-1055.16,4921.26,211.81) },
	        [20]  = { coords = vec3(-1150.40,4940.95,222.26) },
	        [21]  = { coords = vec3(-2294.30,3191.87,32.81) },
	        [22]  = { coords = vec3(-2542.07,2300.32,33.21) },
	        [23]  = { coords = vec3(-3187.55,1050.45,20.88) },
	        [24]  = { coords = vec3(529.31,-1940.16,24.98) }
        }
	}
}

return config