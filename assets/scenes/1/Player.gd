extends Node2D
var deathPlane = 336


var velocity = Vector2()
var Speed = 0
var Gravity = 0
var JumpHeight = 0



var playerInput = Vector2()

var wSoundPlay = 0.0
var wSoundPlayMode = 0
var wSoundPlayL = 0.4

var RestrictMovement = false

var mult = 0


func _ready():
	varReset()
	$PlayerBody/img.play("idol")
	for col in [$PlayerBody/CollisionShape2D2, $PlayerBody/HurtBox/CollisionShape2D3]:
		col.position = Vector2(0, (16 - col.shape.size.y) / 2.0)
	



func _process(delta):
	mult = 60.0 / Engine.max_fps
	playerInput = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	physics()
	if $PlayerBody.global_position.y > deathPlane or Input.is_action_just_pressed("reset"):
		#kill()
		varReset()
	if $PlayerBody.is_on_floor():
		if playerInput.x != 0:
			$PlayerBody/img.play("run")
			wSoundPlay = wrapf(wSoundPlay + delta, 0, wSoundPlayL)
			if wSoundPlay >= wSoundPlayL / 2.0 and wSoundPlayMode == 0:
				$PlayerBody/Run.play()
				wSoundPlayMode = 1
			elif wSoundPlay < wSoundPlayL / 2.0:
				wSoundPlayMode = 0
		else:
			wSoundPlay = 0.0
			wSoundPlayMode = 0
			$PlayerBody/img.play("idol")
	else:
		$PlayerBody/img.play("jump")
	for all in $PlayerBody/HurtBox.get_overlapping_areas():
		if all.scene_file_path == "res://assets/scenes/1/spikeInst.tscn":
			varReset()

func physics():
	if RestrictMovement:
		return
	velocity.y += Gravity * mult
	if $PlayerBody.is_on_floor():
		velocity.y = 0
	if Input.is_action_pressed("fire1") and $PlayerBody.is_on_floor():
		$PlayerBody/Jump.play()
		velocity.y = -JumpHeight
		$PlayerBody.velocity = velocity
		$PlayerBody.floor_snap_length = 0
	elif Input.is_action_just_released("fire1") and velocity.y < 0:
		velocity.y /= 1.2
	if $PlayerBody.is_on_ceiling():
		velocity.y = .1
	if $PlayerBody.is_on_wall():
		velocity.x = 0
	var flip = sign(playerInput.x)
	if flip != 0:
		$PlayerBody/img.flip_h = !bool((flip + 1) / 2.0)
		velocity.x = move_toward(velocity.x, flip * Speed, 20)
	else:
		velocity.x = move_toward(velocity.x, 0, 50)
	velocity.x = clamp(velocity.x, -Speed, Speed)
	$PlayerBody.velocity = velocity
	if abs(velocity.x) < .5:
		$PlayerBody.velocity.x = 0
	$PlayerBody.move_and_slide()
	$PlayerBody.floor_snap_length = 1
	$PlayerBody.global_position.x = clamp($PlayerBody.global_position.x, 0, 480)
	$PlayerBody.global_position.y = clamp($PlayerBody.global_position.y, 0, 360)

func varReset():
	velocity = Vector2()
	$PlayerBody.velocity = velocity
	
	Speed = 1.3 * 60
	Gravity = .25 * 15
	JumpHeight = 5 * 29.2
	$PlayerBody.global_position = get_parent().get_node("Level/spawn").global_position
