tool
extends Button

enum Channels {RED, GREEN, BLUE, ALPHA, ALL}
export(Texture) var texture setget set_texture
export(int) var index = 0 setget set_index
export(Channels) var channel = Channels.ALL setget set_channel

var viewer
var index_label

func set_texture(v: TextureLayered):
	texture = v
	viewer.material.set_shader_param("texarr", v)

func set_index(v: int):
	index = v
	index_label.text = str(v)
	viewer.material.set_shader_param("idx", v)

func set_channel(v: int):
	channel = v
	var chn = Color(1, 1, 1, 1)
	if v < Channels.ALL:
		chn = Color(0, 0, 0, 0)
		chn[v] = 1
	prints(chn)
	viewer.material.set_shader_param("chn", chn)

func _init():
	toggle_mode = true
	size_flags_vertical = SIZE_EXPAND_FILL
	viewer = ColorRect.new()
	viewer.mouse_filter = MOUSE_FILTER_IGNORE
	viewer.material = ShaderMaterial.new()
	viewer.material.shader = preload("res://addons/better-texture-array/ui/layer.shader")
	viewer.rect_min_size = Vector2(64, 64)
	index_label = Label.new()
	index_label.rect_position = Vector2(4, 4)
	
	add_child(viewer)
	add_child(index_label)

func _notification(what):
	if what == NOTIFICATION_RESIZED:
		var pad = 4
		var dim = rect_size.y - pad
		var off = Vector2((rect_size.x - dim) / 2.0, 2)
		viewer.rect_size = Vector2(dim, dim)
		viewer.rect_position = off

func _toggled(pressed: bool):
	if pressed:
		texture.set_meta("layer_selected", index)
