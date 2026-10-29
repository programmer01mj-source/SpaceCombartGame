
extends Area3D

@export var speed: float = 40.0
@export var lifetime: float = 3.0
@export var damage: int = 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(lifetime).timeout
	if is_inside_tree():
		queue_free()

func _physics_process(delta: float) -> void:
	global_position += -global_transform.basis.z * speed * delta

func _on_body_entered(body: Node3D) -> void:
	print("Laser hit: ", body.name)
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
