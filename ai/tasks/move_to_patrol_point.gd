extends BTAction

var navigation_agent: NavigationAgent3D
var vision: Area3D

func _setup():
	navigation_agent = agent.get_node("NavigationAgent3D")
	vision = agent.get_node("VisionArea")
	if not navigation_agent:
		return FAILURE

func _enter():
	agent.state_machine.get_active_state().dispatch("to_patrol")

func _tick(delta: float) -> Status:
	if navigation_agent.is_navigation_finished():
		return SUCCESS
	if vision.is_player_visible():
		return FAILURE

	var next_position = navigation_agent.get_next_path_position()
	var direction = (next_position - agent.global_position).normalized()

	agent.velocity = direction * agent.speed
	agent.move_and_slide()
	agent._rotate_towards(direction, delta)
	return RUNNING
