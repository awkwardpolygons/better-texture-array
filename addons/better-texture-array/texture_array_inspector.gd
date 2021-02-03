tool
extends EditorInspectorPlugin

func can_handle(object):
	return object is Texture3D or object is TextureArray

func parse_property(object, type, path, hint, hint_text, usage):
	var ed = preload("res://addons/better-texture-array/ui/editor.gd").new()
	add_property_editor("data", ed)
