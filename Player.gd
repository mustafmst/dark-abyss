extends KinematicBody2D

const SPEED = 200
const JUMP_FORCE = -300
const JUMP_CHANGE_DIRECTION_FORCE = 10
const GRAVITY = 10
const UP = Vector2(0, -1)

var motion = Vector2()

func _process(delta):
	gravity_work()
	if Input.is_action_pressed("ui_right"):
		move_x(false)
	elif Input.is_action_pressed("ui_left"):
		move_x(true)
	elif is_on_floor():
			motion.x = 0
			$Sprite.play("idle")
	if Input.is_action_just_pressed("ui_up") && is_on_floor():
		motion.y = JUMP_FORCE
		$Sprite.play("jump")
	motion = move_and_slide(motion, UP)
	if motion.x != 0:
		$Sprite.flip_h = !motion.x > 0
	pass

func gravity_work():
	motion.y += GRAVITY
	pass

func move_x(left):
	var direction = 1
	if left:
		direction = -1
	if is_on_floor():
		$Sprite.play("run")
		motion.x = SPEED * direction
	else :
		motion.x += direction*JUMP_CHANGE_DIRECTION_FORCE
		if motion.x > SPEED:
			motion.x = SPEED
		elif motion.x < -SPEED:
			motion.x = -SPEED
	pass