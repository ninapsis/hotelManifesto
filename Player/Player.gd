extends KinematicBody2D

const DustEffect = preload("res://Effects/DustEffect.tscn")
const JumpEffect = preload("res://Effects/JumpEffect.tscn")
const DoubleJumpEffect = preload("res://Effects/DoubleJumpEffect.tscn")
const WallDustEffect = preload("res://Effects/WallDustEffect.tscn")
const PlayerBullet = preload("res://Player/PlayerBullet.tscn")
const PlayerMissile = preload("res://Player/PlayerMissile.tscn")

var PlayerStats = ResourceLoader0.PlayerStats
var MainInstances = ResourceLoader0.MainInstances

#esses exports vao aparecer  no  inspector
export (int) var ACCELERATION = 900
export (int) var MAX_SPEED = 100
export (float) var FRICTION = 0.35
export (int) var GRAVITY = 500
export (int) var WALL_SLIDE_SPEED = 40
export (int) var MAX_WALL_SLIDE_SPEED = 250
export (int) var JUMP_FORCE = 250
export (int) var MAX_SLOPE_ANGLE = 46 # >90 escala parede
export (int) var BULLET_SPEED = 250
export (int) var MISSILE_BULLET_SPEED = 150

enum {
	MOVE,
	WALL_SLIDE
}

var state = MOVE
var invincible = false setget set_invincible
var motion = Vector2.ZERO
var snap_vector =  Vector2.ZERO
var just_jumped = false
var double_jump = true #puts nao eh bem assim.
#var DialogNode = load("res://UI/Control.tscn")

onready var sprite = $Sprite
onready var spriteAnimator = $SpriteAnimator
onready var blinking = $Blinking
# /\ isso dá acesso  aos nodes attached to  the player 
onready var coyoteJumpTimer = $CoyoteJumpTimer #parece q quando vc bota $ vc recebe acesso a variavel
onready var fireBulletTimer = $FireBulletTimer
onready var gun = $Sprite/PlayerGun
onready var muzzle = $Sprite/PlayerGun/Sprite/Muzzle
#onready var powerupDetector = $PowerupDetector
onready var InteractArea = $InteractArea
onready var InteractionBox = $InteractArea/InteractionBox
onready var cameraFollow = $CameraFollow

# warning-ignore:unused_signal
signal hit_door(door)
signal player_died

func set_invincible(value):
	invincible = value

func _ready():
	PlayerStats.connect("player_died", self, "_on_died")
	PlayerStats.missiles_unlocked = SaverAndLoader.custom_data.missiles_unlocked
	QM.NataliaQuest = SaverAndLoader.custom_data.NataliaQuest
	QM.vendorQuest = true
	QM.MicaQuest = true
	MainInstances.Player = self 
	call_deferred("assign_world_camera")
	InteractionBox.disabled = true
	PlayerStats.call_deferred("set_health", PlayerStats.max_health)

# warning-ignore:unused_argument
func _process(delta):
	Interact()

	"""if Input.is_action_just_pressed("interact"):
		var d = DialogNode.instance()
		d.rect_position = Vector2(0,10)
		get_parent().get_node("UI").add_child(d)"""




func queue_free():
	MainInstances.Player = null
	.queue_free()

func Interact():
	if Input.is_action_just_pressed("conversar"):
		InteractionBox.disabled = false
		yield(get_tree().create_timer(0.2),"timeout")
		InteractionBox.disabled = true

func _physics_process(delta):
	just_jumped = false
	
	match state:
		MOVE:
			var input_vector = get_input_vector()
			apply_horizontal_force(input_vector, delta)
			apply_friction(input_vector)
			update_snap_vector()
			jump_check()
			apply_gravity(delta)
			update_animations(input_vector)
			move()
			wall_slide_check()
	
	
		WALL_SLIDE:
			spriteAnimator.play("Wall Slide")
			
			var wall_axis = get_wall_axis()
			if wall_axis != 0:
				sprite.scale.x = wall_axis
			
			wall_slide_jump_check(wall_axis)
			wall_slide_drop(delta)
			move()
			wall_detach(delta, wall_axis)
	
	if Input.is_action_pressed("fire") and fireBulletTimer.time_left == 0:
		fire_bullet()
	
	if Input.is_action_pressed("fire_missile") and fireBulletTimer.time_left == 0:
		if PlayerStats.missiles > 0 and PlayerStats.missiles_unlocked:
			fire_missile()
			PlayerStats.missiles -= 1

func assign_world_camera():
	cameraFollow.remote_path = MainInstances.WorldCamera.get_path()

func save():
	var save_dictionary = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"position_x" : position.x,
		"position_y" : position.y
	}
	return save_dictionary

func fire_bullet():
	var bullet = Utils.instance_scene_on_main(PlayerBullet, muzzle.global_position)
	bullet.velocity = Vector2.RIGHT.rotated(gun.rotation) * BULLET_SPEED
	bullet.velocity.x *= sprite.scale.x #will flip the sprite to the right side
	bullet.rotation = bullet.velocity.angle()
	fireBulletTimer.start()

func fire_missile():
	var missile = Utils.instance_scene_on_main(PlayerMissile, muzzle.global_position)
	missile.velocity = Vector2.RIGHT.rotated(gun.rotation) * MISSILE_BULLET_SPEED
	missile.velocity.x *= sprite.scale.x 
	motion -= missile.velocity * 0.25
	missile.rotation = missile.velocity.angle()
	fireBulletTimer.start()
	

func create_dust_effect():
	SoundFx.play("Step", rand_range(0.6, 1.2), -20)
	var dust_position = global_position
	dust_position.x += rand_range(-4, 4) #slight random amount
	Utils.instance_scene_on_main(DustEffect, dust_position)
	#a linha acima substitui tudo abaixo. parece
	#var dustEffect = DustEffect.instance()
	#get_tree().current_scene.add_child(dustEffect)
	#dustEffect.global_position = dust_position
	#agora é só  chamar create_dust_effect() nas funções q quero

func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#caso eu queira fazer topdown:
	#input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector

func apply_horizontal_force(input_vector, delta):
	if input_vector.x != 0:
		motion.x += input_vector.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		
		#nao tem y por ser platformer, mas é só adicionar. eu  acho

func apply_friction(input_vector):
	if input_vector.x == 0 and is_on_floor():  #if you are not pressing any buttons
		motion.x = lerp(motion.x, 0, FRICTION)
		#create_dust_effect() PERFEITO PRA MEMYS

func update_snap_vector():
	if is_on_floor():
		snap_vector = Vector2.DOWN
	

func jump_check():
	if is_on_floor() or coyoteJumpTimer.time_left > 0:
		if Input.is_action_just_pressed("ui_up"):
			jump(JUMP_FORCE)
			just_jumped = true
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2: #makes sure you cant accidentally double jump
			motion.y = -JUMP_FORCE/2;
		if Input.is_action_just_pressed("ui_up") and double_jump == true:
			jump(JUMP_FORCE * .75)
			Utils.instance_scene_on_main(DoubleJumpEffect, global_position)
			double_jump = false

func jump(force):
	SoundFx.play("Jump", rand_range(0.6, 1.0), -10)
	Utils.instance_scene_on_main(JumpEffect, global_position)
	motion.y = -force
	snap_vector = Vector2.ZERO

func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMP_FORCE) #this tells we can never fall faster than our jump force

#antes da função move tem q adicionar a animação
func update_animations(input_vector):
	"""
	var facing = sign(get_local_mouse_position().x)
	if facing != 0:
		sprite.scale = facing
	ISSO EH SO CASO O PLAYER SUMA QD O MOUSE TIVER 0 GRAU ACIMA DEDLE
	"""
	sprite.scale.x = sign(get_local_mouse_position().x)
	if input_vector.x != 0:
		spriteAnimator.play("Run")
		spriteAnimator.playback_speed = input_vector.x * sprite.scale.x
	else:
		spriteAnimator.playback_speed = 1
		spriteAnimator.play("Idle")
	
	
	if not is_on_floor():
		spriteAnimator.play("Jump")  #como essa  linha vem depois das de cima, ela OVERRIDE as de cima. loucura
	

func move():
	var was_in_air = not is_on_floor()
	var was_on_flor = is_on_floor() #isso vai corrigir o pulinho que dá. TEM QUE SER CODIFICADO ANTES DO MOVE AND SLIDE ABAIXO
	var last_motion = motion
	var last_position = position
	
	motion = move_and_slide_with_snap(motion, snap_vector*4, Vector2.UP, true, 4, deg2rad(MAX_SLOPE_ANGLE)) #this tells the game which direction DOWN is
	#SLOPE!! pra cancelar = motion = move_and_slide(motion, Vector2.UP) 
	
	#landing 
	if was_in_air and is_on_floor():
		motion.x = last_motion.x
		create_dust_effect() #PODE SER 	Utils.instance_scene_on_main(ExplosionEffect, global_position)
		double_jump = true
	
	#just left ground
	if was_on_flor and not is_on_floor() and not just_jumped:
		motion.y = 0
		position.y = last_position.y
		coyoteJumpTimer.start()
		

	#prevent sliding (hack)
	if is_on_floor() and get_floor_velocity().length() == 0 and abs(motion.x) < 1:
		position.x = last_position.x

func wall_slide_check():
	if not is_on_floor() and is_on_wall():
		state = WALL_SLIDE
		double_jump = true
		create_dust_effect()

func get_wall_axis():
	var is_right_wall = test_move(transform, Vector2.RIGHT)
	var is_left_wall = test_move(transform, Vector2.LEFT)
	return int(is_left_wall) - int(is_right_wall)


func wall_slide_jump_check(wall_axis):
	if Input.is_action_just_pressed("ui_up"):
		SoundFx.play("Jump", rand_range(0.6, 1.0), -10)
		motion.x = wall_axis * MAX_SPEED
		motion.y = -JUMP_FORCE/1.25
		state = MOVE
		var dust_position = global_position + Vector2(wall_axis * 3.3, -2)
		var dust = Utils.instance_scene_on_main(WallDustEffect, dust_position)
		dust.scale.x = wall_axis

func wall_slide_drop(delta):
	var max_slide_speed = WALL_SLIDE_SPEED
	if Input.is_action_pressed("ui_down"):
		max_slide_speed = MAX_WALL_SLIDE_SPEED
	motion.y = min(motion.y + GRAVITY * delta, max_slide_speed)


func wall_detach(delta, wall_axis):
	if Input.is_action_just_pressed("ui_right"):
		motion.x = ACCELERATION * delta
		state = MOVE

	if Input.is_action_just_pressed("ui_left"):
		motion.x = -ACCELERATION * delta
		state = MOVE
	if wall_axis == 0 or is_on_floor():
		state = MOVE 

func _on_Hurtbox_hit(damage):
	if not invincible:
		SoundFx.play("Hurt")
		PlayerStats.health -= damage
		blinking.play("Blink")

func _on_died():
	Music.list_stop()
	emit_signal("player_died")
	queue_free()

func _on_PowerupDetector_area_entered(area):
	if area is Powerup:
		area._pickup()

func _on_InteractArea_body_entered(body):
	if body.is_in_group("NPC"):
		body.Dialog_Start()

