
extends CharacterBody3D

signal enemy_destroyed

@export var speed: float = 3.0
@export var health: int = 3

var player: CharacterBody3D
const ENEMY_LASER_SCENE: PackedScene = preload("res://enemy_laser.tscn")

@export var shooting_interval: float = 2.0

var can_shoot: bool = true
func _ready() -> void:
	print("Enemy script is running")

	player = get_tree().current_scene.find_child(
		"Player", true, false
	) as CharacterBody3D

	if player == null:
		print("Player not found!")

func _physics_process(_delta: float) -> void:
	if player == null:
		return

	var direction: Vector3 = player.global_position - global_position
	direction.y = 0

	if direction.length() > 2.0:
		velocity = direction.normalized() * speed
		move_and_slide()
	else:
		velocity = Vector3.ZERO

func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy hit! Remaining health: ", health)

	if health <= 0:
		print("Enemy destroyed!")
		enemy_destroyed.emit()
		queue_free()
		
func _process(_delta: float) -> void:
	if player == null:
		return

	if can_shoot:
		shoot_at_player()


func shoot_at_player() -> void:
	can_shoot = false

	var laser := ENEMY_LASER_SCENE.instantiate() as Area3D
	get_tree().current_scene.add_child(laser)

	var direction_to_player: Vector3 = (
		player.global_position - global_position
	).normalized()

	laser.direction = direction_to_player.normalized()
	laser.global_position = global_position + laser.direction * 2.0
	print("Enemy fired a laser!")
	await get_tree().create_timer(shooting_interval).timeout
	can_shoot = true
