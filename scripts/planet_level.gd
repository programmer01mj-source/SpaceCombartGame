extends Node3D

var enemies_destroyed: int = 0
const REQUIRED_KILLS: int = 3
var elapsed_time: float = 0.0
var level_completed: bool = false
const LEVEL_COMPLETED_SCENE: PackedScene = preload("res://level_completed.tscn")
@onready var timer_label: Label = $HUD/TimerLabel
func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("planet_enemies"):
		enemy.enemy_destroyed.connect(_on_enemy_destroyed)


func _on_enemy_destroyed() -> void:
	enemies_destroyed += 1

	print("Enemies destroyed: ", enemies_destroyed, "/", REQUIRED_KILLS)

	if enemies_destroyed >= REQUIRED_KILLS:
		print("All enemies destroyed! Proceed to the goal.")


func _on_goal_area_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		return

	if enemies_destroyed < REQUIRED_KILLS:
		print("Destroy all enemies before completing the level!")
		return

	level_completed = true
	GameData.level_time = elapsed_time

	print("Planet Level Completed!")
	print("Time taken: ", elapsed_time, " seconds")

	get_tree().change_scene_to_packed(LEVEL_COMPLETED_SCENE)
func _process(delta: float) -> void:
	if not level_completed:
		elapsed_time += delta

		var total_seconds: int = int(elapsed_time)
		var minutes: int = total_seconds / 60
		var seconds: int = total_seconds % 60

		timer_label.text = "Time: %02d:%02d" % [minutes, seconds]
