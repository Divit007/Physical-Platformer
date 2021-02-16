extends KinematicBody2D


const acceleration = 990
const max_speed = 900
const friction = 0
const gravity = 10
const jump_force = 1000
onready var sprite = $Sprite
var motion = Vector2.ZERO

func _physics_process(delta):
	
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		motion.x += x_input * acceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		sprite.flip_h = x_input < 0
		
	
	else:
		motion.x = lerp(motion.x, 0, friction)
	
	motion.y += gravity * delta
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -jump_force
	
	motion = move_and_slide(motion, Vector2.UP)
