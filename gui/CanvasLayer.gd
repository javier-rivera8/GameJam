extends CanvasLayer

@onready var inventory = $InventoryGui
@onready var mirror = $mirror
@onready var password = $password

func _input(event):
	if event.is_action_pressed("toggle_mirror") and mirror.canOpen:
		if mirror.isOpen:
			mirror.close()
		else:
			mirror.open()
	if event.is_action_pressed("toggle_password") and password.canOpen:
		if password.isOpen:
			password.close()
		else:
			password.open()
