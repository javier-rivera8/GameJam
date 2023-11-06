extends Control

const PASSWORD = "7777"

@onready var label = $VBoxContainer/MarginContainer/Label
@onready var tilemap = $"../../TileMap"


var isOpen: bool = false
var canOpen: bool = false

func open():
	visible = true
	isOpen = true
	
func close():
	visible = false
	isOpen = false

func key_press(digit):
	if len(label.text) < 4:
		label.text += str(digit)
		


func _on_button_pressed():
	key_press(1)


func _on_button_2_pressed():
	key_press(2)


func _on_button_3_pressed():
	key_press(3)


func _on_button_4_pressed():
	key_press(4)


func _on_button_5_pressed():
	key_press(5)


func _on_button_6_pressed():
	key_press(6)


func _on_button_7_pressed():
	key_press(7)


func _on_button_8_pressed():
	key_press(8)


func _on_button_9_pressed():
	key_press(9)


func _on_button_10_pressed():
	label.text = ""


func _on_button_11_pressed():
	key_press(0)


func _on_button_12_pressed():
	if label.text == PASSWORD:
		print("CORRECT")
		tilemap.set_layer_enabled(4, false)
		
	else:
		print("Wrong")
		label.text = ""
