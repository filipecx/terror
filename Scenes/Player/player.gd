extends CharacterBody3D

@export var sensitivity = 3
@export var interact_distance: float = 500.0

const SPEED = 50.0
const CROUCH_SPEED = 20.0
const JUMP_VELOCITY = 40.5
var crouched: bool
var last_highlighted: Area3D = null

@onready var raycast = $RayCast3D
@onready var camera = $Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle movement
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed = SPEED
	if Input.is_action_just_pressed("crouch"):
		speed = CROUCH_SPEED
		if !crouched and !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("crouch")
			crouched = true
		elif crouched and $AnimationPlayer.is_playing():
			$AnimationPlayer.play("uncrouch")
			crouched = false

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

	# Interaction logic
	handle_interaction()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / 1000 * sensitivity
		$Camera3D.rotation.x -= event.relative.y / 1000 * sensitivity
		rotation.x = clamp(rotation.x, PI / -2, PI / 2)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -2, 2)

func handle_interaction():
	# Set the raycast length to the interact distance
	raycast.target_position = Vector3(0, 0, -interact_distance)
	raycast.rotation = camera.rotation
	raycast.force_raycast_update()

	if raycast.is_colliding():
		var hit_object = raycast.get_collider()
		if hit_object and hit_object.has_method("highlight"):
			if last_highlighted != hit_object:
				if last_highlighted:
					last_highlighted.reset_highlight()  # Reset the previous highlight
				hit_object.highlight()
				last_highlighted = hit_object
			if Input.is_action_just_pressed("interact") and hit_object.has_method("interact"):
				hit_object.interact()
		else:
			reset_highlights()
	else:
		reset_highlights()

func reset_highlights():
	if last_highlighted:
		last_highlighted.reset_highlight()
		last_highlighted = null
