extends Area2D

@onready var mirror = $"../../CanvasLayer/mirror"

func enable():
	mirror.canOpen = true

func disable():
	mirror.visible = false
	mirror.isOpen = false
	mirror.canOpen = false
