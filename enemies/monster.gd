extends CharacterBody2D

@export var speed = 50
@export var limit = 0.5

@onready var animations = $AnimatedSprite2D

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
	var animationString = "walkRight"
	if velocity.x < 0:
		animationString = "walkLeft"
	
	animations.play(animationString)

func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()

	
