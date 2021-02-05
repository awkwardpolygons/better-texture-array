tool
extends EditorInspectorPlugin

var undo_redo: UndoRedo

func can_handle(object):
	return object is Texture3D or object is TextureArray

func parse_property(object, type, path, hint, hint_text, usage):
	var ed = preload("res://addons/better-texture-array/ui/editor.gd").new()
	ed.undo_redo = undo_redo
	add_property_editor("data", ed)
