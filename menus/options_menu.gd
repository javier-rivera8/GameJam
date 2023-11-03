extends Control

func _on_volume_pressed():
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")