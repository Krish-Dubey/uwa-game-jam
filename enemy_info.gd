extends Node
class_name EnemyInfo

var EnemiesList = [
	{
		"enemyName": "Walker",
		"resourcePath": "res://scenes/enemies/walkertest.tscn"
	}
]

func getAllEnemyInfo():
	var LoadedEnemies = []
	for enemy in EnemiesList:
		LoadedEnemies.append({
			"LoadedRes" : load(enemy["resourcePath"]),
			"EnemyName" : enemy["enemyName"]
		})
	return LoadedEnemies
