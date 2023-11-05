extends CharacterBody2D

signal healthChanged

@export var speed: int = 35
@onready var animations = $AnimationPlayer
@onready var effects = $Effects
@onready var hurtBox = $hurtBox
@onready var hurtTimer = $hurtTimer
@onready var label = $Label
@onready var weapon = $Weapon
@onready var key = $"../../keyArea"
@onready var enemy = $"../monster"
@onready var enemy2 = $"../monster2"
@onready var enemy3 = $"../monster3"

@export var maxHealth = 3
@onready var currentHealth: int = maxHealth

@export var knockbackPower: int = 500

@export var inventory: Inventory

var lastAnimationDirection: String = "Down"
var isHurt: bool = false
var isAttacking: bool = false

func _ready():
	effects.play("RESET")

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed

	if Input.is_action_just_pressed("attack"):
		attack()

func attack():
	animations.play("attack" + lastAnimationDirection)
	isAttacking = true
	weapon.visible = true
	await animations.animation_finished
	weapon.visible = false
	isAttacking = false

func updateAnimation():
	if isAttacking:
		return

	if velocity.length() == 0:
		animations.stop()
	else:
		var direction = "Right"
		if velocity.x < 0: direction = "Left"

		animations.play("walk" + direction)
		lastAnimationDirection = direction
	
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		
func _physics_process(delta):
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name== "hitBox":
				hurtByEnemy(area)
	

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
		
	healthChanged.emit(currentHealth)
	isHurt = true
		
	knockback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false

func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
	if area.has_method("enable"):
		area.enable()
		label.visible = true
	if area.has_method("enableDoor"):
		area.enableDoor()
		label.visible = true
	if area.has_method("gotKey"):
		area.gotKey()
	if area.has_method("openDoor") and key.hasKey:
		area.openDoor()
		enemy.follow()
		enemy2.follow()
		enemy3.follow()
		

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()


func _on_hurt_box_area_exited(area):
	if area.has_method("disable"):
		area.disable()
		label.visible = false
	if area.has_method("disableDoor"):
		area.disableDoor()
		label.visible = false
