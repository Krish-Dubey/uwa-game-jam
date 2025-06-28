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
		"resourcePath": "res://scenes/enemies/walkertest.tscn",
		"cost" : 2,
		"rarity" : "common"
	}
]

var LoadedEnemies = []

var EnemiesCategoryIndex = {
	"common" = []
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
