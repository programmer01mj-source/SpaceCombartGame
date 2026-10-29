
extends Area3D

@export var speed: float = 20.0
@export var damage: int = 1
@export var lifetime: float = 4.0

var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	body_entered.connect(_on_body_entered)

	await get_tree().create_timer(lifetime).timeout

	if is_inside_tree():
		queue_free()

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("Enemy laser hit the player!")

		if body.has_method("take_damage"):
			body.take_damage(damage)

		queue_free()
