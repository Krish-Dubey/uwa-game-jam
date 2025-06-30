extends Node
class_name EnemyInfo

var EnemiesList = [
	{
		"enemyName": "Walker",
		"resourcePath": "res://scenes/enemies/walkertest.tscn",
		"cost" : 1,
		"rarity" : "common"
	},
	
	{
		"enemyName": "FastWalker",
		"resourcePath": "res://scenes/enemies/fastwalker.tscn",
		"cost" : 2,
		"rarity" : "uncommon"
	},
	
	{
		"enemyName": "LargeWalker",
		"resourcePath": "res://scenes/enemies/largewalker.tscn",
		"cost" : 2,
		"rarity" : "uncommon"
	},
	{
		"enemyName": "Flyers",
		"resourcePath": "res://scenes/enemies/flyers.tscn",
		"cost" : 1,
		"rarity" : "rare"
	},
	{
		"enemyName": "Ant",
		"resourcePath": "res://scenes/enemies/ant.tscn",
		"cost" : 3,
		"rarity" : "rare"
	},
	{
		"enemyName": "Wrecker",
		"resourcePath": "res://scenes/enemies/wrecker.tscn",
		"cost" : 10,
		"rarity" : "boss"
	}
	
]

var LoadedEnemies = []

var EnemiesCategoryIndex = {
	"common" = [],
	"uncommon" = [],
	"rare" = [],
	"boss" = []
}

func loadAllEnemies():
	for enemy in EnemiesList:
		enemy["loadIndex"] = LoadedEnemies.size()
		LoadedEnemies.append(load(enemy["resourcePath"]))
		EnemiesCategoryIndex[enemy["rarity"]].append(enemy["loadIndex"])
	return EnemiesList
	
func getEnemiesPackedNode(index):
	return LoadedEnemies[index]

func getCategory(category):
	return EnemiesCategoryIndex[category]
