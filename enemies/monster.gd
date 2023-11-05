extends CharacterBody2D

@export var speed = 0
@export var limit = 0.5
@export var player: Node2D

@onready var nav_agent :=  $NavigationAgent2D as NavigationAgent2D
@onready var animations = $AnimatedSprite2D

var animate: bool = false

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = startPosition + Vector2(0, 3 * 32)

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	
	velocity = moveDirection.normalized()*speed 

func updateAnimation():
	if !animate:
		return
	var animationString = "walkRight"
	if velocity.x < 0:
		animationString = "walkLeft"
	
	animations.play(animationString)

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	updateAnimation()

func makepath() -> void:
	nav_agent.target_position = player.global_position


func _on_timer_timeout():
	makepath()

func follow():
	speed = 75
	animate = true
