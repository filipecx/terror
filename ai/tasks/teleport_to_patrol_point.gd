extends BTAction

var navigation_agent: NavigationAgent3D
var vision: Area3D
var patrol_points: Array[Node]

func _setup():
	navigation_agent = agent.get_node("NavigationAgent3D")
	vision = agent.get_node("VisionArea")
	patrol_points = agent.get_node("PatrolPoints").get_children()
	if not navigation_agent:
		return FAILURE


func _tick(_delta: float) -> Status:
	if vision.is_player_visible():
		return FAILURE

	var next_position = patrol_points[0].global_position
	next_position.y += 0.2

	agent.position = next_position
	return SUCCESS
