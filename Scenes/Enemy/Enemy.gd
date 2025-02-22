extends CharacterBody3D

# Variables to customize enemy behavior
@export var speed: float = 5.0
@export var acceleration: float = 10.0  # Smoother movement
@export var friction: float = 5.0  # Deceleration when stopping
@export var follow_range: float = 20.0
@export var stop_range: float = 2.0
@export var rotation_speed: float = 5.0

var player: CharacterBody3D

func _ready():
	player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta: float):
	pass
	# if player and is_instance_valid(player):
	# 	follow_player(delta)

func move(direction: Vector3, speed_multiplier: float):
	if direction.length() > 0:
		# Accelerate in the given direction
		velocity = velocity.lerp(direction * speed * speed_multiplier, acceleration * get_physics_process_delta_time())
	else:
		# Apply friction when stopping
		velocity = velocity.lerp(Vector3.ZERO, friction * get_physics_process_delta_time())

	# Apply movement using Godot's physics engine
	move_and_slide()

func follow_player(delta: float):
	# Calculate direction to the player
	var direction = (player.global_position - global_position)
	var distance_to_player = direction.length()

	if distance_to_player <= follow_range and distance_to_player > stop_range:
		# Normalize direction for movement
		direction = direction.normalized()

		# Rotate smoothly towards the player
		var target_rotation = Basis.looking_at(player.global_position - global_position, Vector3.UP)
		transform.basis = transform.basis.slerp(target_rotation, rotation_speed * delta)

		# Move towards the player
		velocity = direction * speed
	else:
		# Stop moving if outside follow range or too close
		velocity = Vector3.ZERO

	# Apply movement using CharacterBody3D's move_and_slide
	move_and_slide()

func check_for_self(node):
	if node == self:
		return true
	return false
