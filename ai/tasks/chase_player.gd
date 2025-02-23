extends BTAction

@export var chase_speed: float = 7.0

var navigation_agent: NavigationAgent3D

func _setup():
	navigation_agent = agent.get_node("NavigationAgent3D")
	if not navigation_agent:
		return FAILURE

func _tick(delta: float) -> Status:
	var vision_area = agent.get_node("VisionArea")
	if not vision_area or not vision_area.player:
		return FAILURE  # If player is lost, stop chasing

	var player_position = vision_area.player.global_position
	navigation_agent.set_target_position(player_position)

	if not navigation_agent.is_navigation_finished():
		var next_position = navigation_agent.get_next_path_position()
		var direction = (next_position - agent.global_position).normalized()

		# Apply movement
		agent.velocity = direction * chase_speed
		agent.move_and_slide()
		agent._rotate_towards(direction, delta)

	return RUNNING
