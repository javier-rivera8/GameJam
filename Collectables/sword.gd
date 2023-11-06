extends "res://Collectables/Collectable.gd"

@onready var animations = $AnimationPlayer
@onready var swing = $AudioStreamPlayer
var weapon = false

func collect(inventory: Inventory):
	animations.play("spin")
	await animations.animation_finished
	super(inventory)

func hasWeapon():
	weapon = true

func canAttack():
	return weapon
