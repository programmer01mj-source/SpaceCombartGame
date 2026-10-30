extends StaticBody3D

@export var shooting_interval: float = 2.0

var player: CharacterBody3D
var can_shoot: bool = true

const ENEMY_LASER_SCENE: PackedScene = preload("res://enemy_laser.tscn")

func _ready() -> void:
	player = get_tree().current_scene.find_child("Player", true, false) as CharacterBody3D

func _process(_delta: float) -> void:
	if player == null:
		return

	if can_shoot:
		shoot_at_player()

func shoot_at_player() -> void:
	can_shoot = false

	var laser := ENEMY_LASER_SCENE.instantiate() as Area3D
	get_tree().current_scene.add_child(laser)

	var direction_to_player: Vector3 = (player.global_position - global_position).normalized()

	laser.direction = direction_to_player
	laser.global_position = global_position + direction_to_player * 2.0

	await get_tree().create_timer(shooting_interval).timeout
	can_shoot = true
