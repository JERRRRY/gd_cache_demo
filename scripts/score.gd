extends Node

@onready var score_label: Label = $"../../../score_label"

func add_point():
	var cache_score = global_cache.Get("score",  {"default": 0}) + 1
	global_cache.Set("score", cache_score)
	print("cache save:{score,"+str(cache_score)+"}")
	print("cache status:")
	print(global_cache._to_string())
	score_label.text = "score:"+str(cache_score)
	
