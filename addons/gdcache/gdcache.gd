@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("AbstractCache", "Node", AbstractCache, null)
	add_custom_type("CacheMonitor", "Node", CacheMonitor, null)
	pass


func _exit_tree() -> void:
	remove_custom_type("AbstractCache")
	remove_custom_type("CacheMonitor")
	pass
