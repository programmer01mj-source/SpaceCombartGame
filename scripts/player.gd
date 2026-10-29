
extends CharacterBody3D
const GAME_OVER_SCENE: PackedScene = preload("res://game_over.tscn")
@export var speed: float = 12.0
@export var health: int = 100
const LASER_SCENE: PackedScene = preload("res://player_laser.tscn")
@onready var hud = get_tree().current_scene.find_child("HUD", true, false)
@onready var muzzle: Marker3D = $Muzzle
@onready var bob_model: Node3D = $ShipModel.find_child("Bob", true, false) as Node3D
@onready var challenger_model: Node3D = $ShipModel.find_child("Challenger", true, false) as Node3D

func _physics_process(_delta: float) -> void:
	print("Player script is running")
	var direction := Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		direction.z -= 1.0
	if Input.is_action_pressed("move_back"):
		direction.z += 1.0
	if Input.is_action_pressed("move_left"):
		direction.x -= 1.0
	if Input.is_action_pressed("move_right"):
		direction.x += 1.0

	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

	if Input.is_action_just_pressed("shoot"):
		shoot_laser()

func shoot_laser() -> void:
	var laser := LASER_SCENE.instantiate() as Area3D
	get_tree().current_scene.add_child(laser)
	laser.global_position = muzzle.global_position
	laser.global_rotation = global_rotation


func take_damage(amount: int) -> void:
	if health <= 0:
		return

	health = max(health - amount, 0)
	print("Player health: ", health)

	if hud != null:
		hud.update_health(health)

	if health <= 0:
		print("Game Over!")
		get_tree().paused = true

		var game_over = GAME_OVER_SCENE.instantiate()
		game_over.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		get_tree().current_scene.add_child(game_over)

func _ready() -> void:
	if bob_model == null:
		print("Bob model was not found")
	else:
		bob_model.visible = GameData.selected_ship == "Bob"

	if challenger_model == null:
		print("Challenger model was not found")
	else:
		challenger_model.visible = GameData.selected_ship == "Challenger"

	print("Selected ship: ", GameData.selected_ship)
