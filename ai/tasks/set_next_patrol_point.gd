extends BTAction

var navigation_agent: NavigationAgent3D
@export var current_point_index_var: StringName = &"current_point_index"
@export var patrol_points_var: StringName = &"patrol_points"
var cycle_completed: bool = false
var patrol_points: Array[Node]

func _setup():
	navigation_agent = agent.get_node("NavigationAgent3D")
	if not navigation_agent:
		return FAILURE
	patrol_points = agent.get_node("PatrolPoints").get_children()


func _tick(_delta: float) -> Status:
	blackboard.set_var(patrol_points_var, patrol_points)
	if patrol_points.is_empty():
		return FAILURE

	if navigation_agent.is_navigation_finished():
		var current_index = (blackboard.get_var(current_point_index_var, -1) + 1) % patrol_points.size()
		blackboard.set_var(current_point_index_var, current_index)

		var target_position = patrol_points[current_index].global_position
		navigation_agent.set_target_position(target_position)
		return SUCCESS
	else:
		return FAILURE
		# var next_position = navigation_agent.get_next_path_position()
		# var direction = (next_position - agent.global_position).normalized()
		#
		# agent.velocity = direction * agent.speed
		# agent.move_and_slide()
		# agent._rotate_towards(direction, delta)
		#
		# return RUNNING
