extends Area2D

@onready var password = $"../CanvasLayer/password"

func enableDoor():
	password.canOpen = true

func disableDoor():
	password.visible = false
	password.isOpen = false
	password.canOpen = false
