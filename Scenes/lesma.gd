extends CharacterBody3D

# Variables to customize enemy behavior
@export var speed: float = 5.0          # Movement speed
@export var follow_range: float = 20.0  # Distance within which the enemy starts following
@export var stop_range: float = 2.0     # Distance at which the enemy stops moving
@export var rotation_speed: float = 5.0 # How quickly the enemy rotates towards the player

# Reference to the player node
#@export var player_path: 
var player: CharacterBody3D

func _ready():
	player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta: float):
	if player and is_instance_valid(player):
		follow_player(delta)

func follow_player(delta: float):
	# Calculate direction to the player
	var direction = (player.global_position - global_position)
	var distance_to_player = direction.length()

	if distance_to_player <= follow_range and distance_to_player > stop_range:
		# Normalize direction for movement
		direction = direction.normalized()

		# Rotate smoothly towards the player
		var target_rotation = transform.basis.looking_at(player.global_position - global_position, Vector3.UP)
		transform.basis = transform.basis.slerp(target_rotation, rotation_speed * delta)

		# Move towards the player
		velocity = direction * speed
	else:
		# Stop moving if outside follow range or too close
		velocity = Vector3.ZERO

	# Apply movement using CharacterBody3D's move_and_slide
	move_and_slide()
