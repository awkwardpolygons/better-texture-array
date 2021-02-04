tool
extends EditorProperty

const Layer = preload("res://addons/better-texture-array/ui/layer.gd")
var create_button
var create_dialog
var layer_box
var layer_list
var layer_group
var toolbar

func _init():
	label = "Layers"
	create_button = Button.new()
	create_button.text = "Create"
	
	layer_box = VBoxContainer.new()
	layer_list = VBoxContainer.new()
	layer_group = ButtonGroup.new()
	
	toolbar = HBoxContainer.new()
	var tbb_vis = CheckButton.new()
	var tbb_sep = VSeparator.new()
	var tbb_grp = ButtonGroup.new()
	var tbb_red = Button.new()
	var tbb_grn = Button.new()
	var tbb_blu = Button.new()
	var tbb_alp = Button.new()
	var tbb_all = Button.new()
	
	toolbar.alignment = BoxContainer.ALIGN_CENTER
	tbb_sep.size_flags_horizontal = SIZE_EXPAND_FILL
	tbb_sep.add_stylebox_override("separator", StyleBoxEmpty.new())
	tbb_vis.toggle_mode = true
	tbb_red.toggle_mode = true
	tbb_grn.toggle_mode = true
	tbb_blu.toggle_mode = true
	tbb_alp.toggle_mode = true
	tbb_all.toggle_mode = true
	tbb_vis.text = "Show"
	tbb_red.icon = preload("res://addons/better-texture-array/icons/RED.svg")
	tbb_grn.icon = preload("res://addons/better-texture-array/icons/GREEN.svg")
	tbb_blu.icon = preload("res://addons/better-texture-array/icons/BLUE.svg")
	tbb_alp.icon = preload("res://addons/better-texture-array/icons/ALPHA.svg")
	tbb_all.icon = preload("res://addons/better-texture-array/icons/ALL.svg")
	tbb_red.group = tbb_grp
	tbb_grn.group = tbb_grp
	tbb_blu.group = tbb_grp
	tbb_alp.group = tbb_grp
	tbb_all.group = tbb_grp
	tbb_all.pressed = true
	
	tbb_red.connect("toggled", self, "_toggle_channel", [Layer.Channels.RED])
	tbb_grn.connect("toggled", self, "_toggle_channel", [Layer.Channels.GREEN])
	tbb_blu.connect("toggled", self, "_toggle_channel", [Layer.Channels.BLUE])
	tbb_alp.connect("toggled", self, "_toggle_channel", [Layer.Channels.ALPHA])
	tbb_all.connect("toggled", self, "_toggle_channel", [Layer.Channels.ALL])
	
	toolbar.add_child(tbb_vis)
	toolbar.add_child(tbb_sep)
	toolbar.add_child(tbb_red)
	toolbar.add_child(tbb_grn)
	toolbar.add_child(tbb_blu)
	toolbar.add_child(tbb_alp)
	toolbar.add_child(tbb_all)
	toolbar.add_constant_override("separation", 0)
	
	layer_list.visible = false
	layer_box.add_child(toolbar)
	layer_box.add_child(layer_list)
	
	tbb_vis.connect("toggled", self, "_toggle_layers")

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
	add_child(create_button)
	add_child(layer_box)
#	add_child(create_dialog)
	set_bottom_editor(layer_box)

func update_property():
	update_list()

func _toggle_layers(visible: bool):
	layer_list.visible = visible

func _toggle_channel(visible: bool, chn: int):
	for layer in layer_list.get_children():
		layer.channel = chn
