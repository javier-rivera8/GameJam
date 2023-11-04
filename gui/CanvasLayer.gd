extends CanvasLayer

@onready var inventory = $InventoryGui
@onready var mirror = $mirror

func _input(event):
	if event.is_action_pressed("toggle_mirror") and mirror.canOpen:
		if mirror.isOpen:
			mirror.close()
		else:
			mirror.open()
