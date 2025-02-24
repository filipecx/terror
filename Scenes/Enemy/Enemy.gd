extends CharacterBody3D
class_name Enemy

# Variables to customize enemy behavior
@export var speed: float = 2.0
@export var acceleration: float = 1.0  # Smoother movement
@export var friction: float = 5.0  # Deceleration when stopping
@export var follow_range: float = 20.0
@export var stop_range: float = 2.0
@export var rotation_speed: float = 5.0
@export var time_multiplier: float = 10.0
@export var behavior_tree: BTPlayer

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var patrol_points: Node = $PatrolPoints

var player: CharacterBody3D


func _ready():
	player = get_tree().get_first_node_in_group("Player")
	behavior_tree.blackboard.set_var("&patrol_points", patrol_points.get_children())
	await get_tree().physics_frame

func _physics_process(delta: float):
	pass

func _rotate_towards(direction: Vector3, delta: float):
	if direction.length() > 0:
		var target_rotation = Basis.looking_at(direction, Vector3.UP)
		transform.basis = transform.basis.slerp(target_rotation, rotation_speed * delta)


func check_for_self(node):
	if node == self:
		return true
	return false

func move(direction: Vector3, speed_multiplier: float):
	if direction.length() > 0:
		# Accelerate in the given direction
		velocity = velocity.lerp(direction * speed * speed_multiplier, acceleration * get_physics_process_delta_time())
	else:
		# Apply friction when stopping
		velocity = velocity.lerp(Vector3.ZERO, friction * get_physics_process_delta_time())

	move_and_slide()
