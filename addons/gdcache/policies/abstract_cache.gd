extends Node
class_name AbstractCache

var policy: String = ""

signal get_key(key: Variant, hit: bool)
signal set_key(key: Variant, value)
signal evict_key(key: Variant)
signal fetch_key(key: Variant)

@export_range(1, 65536, 1) var CAPACITY: int = 3
var _cache: Dictionary = {}
var _cache_file_path = "res://cache/cache.json"

func __setup() -> void:
	pass
	
# Load the data from a file when the game starts
func _ready():
	load_data_from_file(_cache_file_path)
	
# Function to load the data from the file to the cache
func load_data_from_file(file_path: String):
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var parsed_result = JSON.parse_string(file.get_as_text())
		if parsed_result is Dictionary:
			_cache = parsed_result
			print(_cache)
		else:
			print("not dictionary")
		file.close()
		file = null
	else:
		print("data not exist")

# Save the data to a file before leaving the game
func _exit_tree():
	save_data_to_file(_cache_file_path)
	
func save_data_to_file(file_path: String):
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(_cache))
	file.close()
	file = null
	
func _init(capacity: int = CAPACITY) -> void:
	randomize()
	self.CAPACITY = capacity
	self.name = "cache_%s" % [randi() + capacity]
	__setup()

# API
# set default when requesting, ex. cache.Get("player_score", {"default": 0})
func Get(key: Variant, options: Dictionary = {}) -> Variant:
	var val: Variant = __get(key, options.get("default", null))
	get_key.emit(key, val != null)
	return val

# should be overridden
func __get(key: Variant, default: Variant = null, options: Dictionary = {}) -> Variant:
	return _cache.get(key, default)


func Set(key: Variant, val: Variant, options: Dictionary = {}) -> void:
	__set(key, val, options)
	set_key.emit(key, val)

# Cache specific set function, should be overridden
func __set(key: Variant, val: Variant, options: Dictionary = {}) -> void:
	_cache[key] = val

func Evict(key: Variant, options: Dictionary = {}) -> bool:
	var evicted: bool = __evict(key, options)
	if evicted: 
		evict_key.emit(key)
	return evicted

func __evict(key: Variant, options: Dictionary = {}) -> bool:
	return _cache.erase(key)

# Utility Functions
func has(key: Variant) -> bool:
	return _cache.has(key)


func keys() -> Array[Variant]:
	return _cache.keys()


# Returns the size of the cache
func size() -> int:
	return _cache.size()

# Returns the capacity of the cache
func capacity() -> int:
	return CAPACITY

func _to_string() -> String:
	return str(_cache)
