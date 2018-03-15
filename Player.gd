extends KinematicBody2D

const SPEED = 100
const MAX_SPEED = 150
const JUMP_FORCE = -250
const JUMP_CHANGE_DIRECTION_FORCE = 10
const GRAVITY = 10
const UP = Vector2(0, -1)

var motion = Vector2(0,0)

func _physics_process(delta):
	motion.y += GRAVITY
	motion = move_and_slide(motion, UP)
	pass

func _process(delta):
	var is_on_floor = is_on_floor()
	if Input.is_action_pressed("ui_right"):
		set_motion(false, is_on_floor)
	elif Input.is_action_pressed("ui_left"):
		set_motion(true, is_on_floor)
	else :
			motion.x = 0
	if motion.x == 0 && motion.y == 0 :
			$Sprite.play("idle")
	if Input.is_action_just_pressed("ui_up") && is_on_floor:
		motion.y = JUMP_FORCE
		$Sprite.play("jump")
	if motion.x != 0:
		$Sprite.flip_h = !motion.x > 0
	pass

func set_motion(is_moving_left, on_floor):
	var direction = 1
	if is_moving_left:
		direction = -1
	motion.x = MAX_SPEED * direction
	if on_floor:
		$Sprite.play("run")
	pass