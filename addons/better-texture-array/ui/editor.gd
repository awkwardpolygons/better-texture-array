tool
extends EditorProperty

const Layer = preload("res://addons/better-texture-array/ui/layer.gd")
var create_button
var create_dialog
var layer_list
var layer_group

func _init():
	label = "Layers"
	create_button = Button.new()
	create_button.text = "Create"
	
	layer_list = VBoxContainer.new()
	layer_group = ButtonGroup.new()

func update_list():
	var texarr = get_edited_object()
	var children = layer_list.get_children()
	var have = children.size()
	var want = texarr.get_depth() if texarr else 0
	layer_list.rect_min_size.y = want * 192

	for i in have:
		var ch = children[i]
		layer_list.remove_child(ch)
#		ch.disconnect("update_layer", self, "_on_update_layer")
#		ch.main_button.disconnect("toggled", self, "_on_layer_toggled")
		ch.queue_free()

	for i in want:
		var layer = Layer.new()
		layer_list.add_child(layer)
		layer.index = i
		layer.texture = texarr
		layer.rect_min_size = Vector2(128, 128)
		layer.group = layer_group
#		layer.connect("update_layer", self, "_on_update_layer")
#		layer.main_button.connect("toggled", self, "_on_layer_toggled", [i])

func _ready():
	label = "Layers"
	rect_min_size = Vector2(0, 256)
	add_child(layer_list)
	add_child(create_button)
#	add_child(create_dialog)
	set_bottom_editor(layer_list)

func update_property():
	update_list()
