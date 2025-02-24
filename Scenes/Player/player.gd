extends CharacterBody3D

@export var sensitivity = 3
@export var credit: int = 0
@export var money: float = 0.0
@export var interact_distance: float = 10.0

@onready var camera = $Camera3D
@onready var raycast = $Camera3D/RayCast3D
@onready var inventory = $Inventory
@onready var walkingSound = $AudioStreamPlayer3D


signal interaction_prompt
signal update_money
signal update_credit
signal slime_hit(speed_multiplier: float)
signal safe

const SPEED = 5.0
const CROUCH_SPEED = 2.0
const JUMP_VELOCITY = 5.0
var crouched: bool
var last_object_on_aim: PhysicsBody3D = null


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if not self.get_meta("can_jump", true):
			print("Jumping is disabled in this area.")
			return
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
		if is_on_floor():
			if !walkingSound.playing:
				walkingSound.pitch_scale = randf_range(1, 1.2)
				walkingSound.play()
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
		camera.rotation.x -= event.relative.y / 1000 * sensitivity
		rotation.x = clamp(rotation.x, PI / -2, PI / 2)
		camera.rotation.x = clamp(camera.rotation.x, -2, 2)

func handle_interaction():
	# Set the raycast length to the interact distance
	raycast.target_position = Vector3(0, 0, -interact_distance)
	raycast.force_raycast_update()

	if raycast.is_colliding():
		var hit_object = raycast.get_collider()
		if hit_object and hit_object != last_object_on_aim:
			reset_highlights()  # Reset the previous object's highlight
			if hit_object.has_method("highlight"):
				if hit_object.is_interactable:
					hit_object.highlight()
			if hit_object.has_method("get_interact_text"):
				if hit_object.is_interactable:
					emit_signal("interaction_prompt", hit_object.get_interact_text())
			else:
				emit_signal("interaction_prompt", "")
			last_object_on_aim = hit_object
		if Input.is_action_just_pressed("interact") and hit_object.has_method("interact"):
			hit_object.interact(self)
	else:
		reset_highlights()
		emit_signal("interaction_prompt", "")

func reset_highlights():
	if last_object_on_aim and is_instance_valid(last_object_on_aim):
		if last_object_on_aim.has_method("highlight"):
			last_object_on_aim.reset_highlight()
			last_object_on_aim = null

func add_to_inventory(item_data: ItemData, quantity: int = 1) -> bool:
	if inventory:
		return inventory.add_item(item_data, quantity)
	return false

func remove_from_inventory(item_data: ItemData, quantity: int = 1) -> bool:
	if inventory:
		return inventory.remove_item(item_data, quantity)
	return false

func add_money(amount: float) -> void:
	money += amount
	emit_signal("update_money", money)

func subtract_money(amount: float) -> void:
	money -= amount
	emit_signal("update_money", money)

func add_credit(amount: int = 1) -> void:
	credit += amount
	emit_signal("update_credit", credit)

func subtract_credit(amount: int = -1) -> void:
	credit -= amount
	emit_signal("update_credit", credit)

func get_item(item_data: ItemData) -> Dictionary:
	if inventory:
		return inventory.get_item(item_data)
	return {}

func has_item(item_data: ItemData) -> bool:
	if inventory:
		return inventory.has_item(item_data)
	return false

func has_items(item_data: Array[ItemData]) -> bool:
	if inventory:
		for item in item_data:
			if not inventory.has_item(item):
				return false
		return true
	return false

func get_hitted(enemy: Enemy):
	emit_signal("slime_hit", enemy.time_multiplier)

func get_safe():
	emit_signal("safe")
