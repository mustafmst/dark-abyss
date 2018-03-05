extends KinematicBody2D

const SPEED = 100
const MAX_SPEED = 150
const JUMP_FORCE = -250
const JUMP_CHANGE_DIRECTION_FORCE = 10
const GRAVITY = 10
const UP = Vector2(0, -1)

var motion = Vector2(0,0)

func _process(delta):
	print(delta)
	print(is_on_floor())
	gravity_work(delta)
	if Input.is_action_pressed("ui_right"):
		motion.x = MAX_SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -MAX_SPEED
	elif is_on_floor():
			motion.x = 0
	if Input.is_action_just_pressed("ui_up") && is_on_floor():
		motion.y = JUMP_FORCE
	motion = move_and_slide(motion, UP)
	if motion.x != 0:
		$Sprite.flip_h = !motion.x > 0
	pass

func gravity_work(delta):
	motion.y += GRAVITY
	pass