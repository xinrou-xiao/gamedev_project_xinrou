extends Node

var _cache: Dictionary = {}


func get_texture(path: String) -> Texture2D:
	if not _cache.has(path):
		_cache[path] = load(path)
	return _cache[path]
