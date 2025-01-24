extends CharacterBody2D

#Export global variables
@export var move_speed : float = 100
@export var direction = ""
@export var is_fishing = false

func _physics_process(_delta):
	#Handle input actions
	get_input()
	
	#Create velocity based on move speed
	velocity = Input.get_vector("left", "right", "up", "down").normalized() * move_speed
	
	#Move and slide function
	move_and_slide()

@onready var _animated_sprite = $AnimatedSprite2D

func get_input():
	#Map movement animations to input and stop them when input released
	if Input.is_action_pressed("right"):
		_animated_sprite.play("Walk Right")
		direction = "Right"
		return direction
		
	if Input.is_action_just_released("right"):
		_animated_sprite.stop()
		is_fishing = false
		return is_fishing
		
	elif Input.is_action_pressed("left"):
		_animated_sprite.play("Walk Left")
		direction = "Left"
		return direction
		
	if Input.is_action_just_released("left"):
		_animated_sprite.stop()
		is_fishing = false
		return is_fishing
		
	elif Input.is_action_pressed("up"):
		_animated_sprite.play("Walk Up")
		direction = "Up"
		return direction
		
	if Input.is_action_just_released("up"):
		_animated_sprite.stop()
		is_fishing = false
		return is_fishing
		
	elif Input.is_action_pressed("down"):
		_animated_sprite.play("Walk Down")
		direction = "Down"
		return direction
		
	if Input.is_action_just_released("down"):
		_animated_sprite.stop()
		is_fishing = false
		return is_fishing
		
	#Map fishing animation to input
	elif Input.is_action_just_pressed("fish"):
		var fish = "Fish "
		var formatted_direction = (fish + direction)
		if is_fishing == false:
			_animated_sprite.play(formatted_direction)
			is_fishing = true
			return is_fishing
		else:
			_animated_sprite.play_backwards(formatted_direction)
			await get_tree().create_timer(1.0).timeout
			_animated_sprite.stop()
			is_fishing = false
			return is_fishing

# test
