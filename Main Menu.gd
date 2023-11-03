extends Control

func _on_startgame_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://menus/options_menu.tscn")

func _on_quitgame_pressed():
	get_tree().quit()