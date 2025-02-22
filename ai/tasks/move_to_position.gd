extends BTAction

@export var target_pos_var := &"pos"
@export var dir_var := &"dir"

@export var speed_var = 40
@export var tolerance = 10
# @export var min_movement_threshold = 2.0
# @export var stuck_time_threshold = 1.0
#
# var last_position: Vector3
# var stuck_timer: float = 0.0
# func _ready():
# 	last_position = agent.global_position

func _tick(_delta: float) -> Status:
	var target_pos: Vector3 = blackboard.get_var(target_pos_var, Vector3.ZERO)
	var dir: Vector3 = blackboard.get_var(dir_var, Vector3.ZERO)

	var zOnTarget = abs(agent.global_position.z - target_pos.z) < tolerance
	var xOnTarget = abs(agent.global_position.x - target_pos.x) < tolerance

	# if agent.global_position.distance_to(last_position) < min_movement_threshold:
	# 	stuck_timer += delta
	# else:
	# 	stuck_timer = 0
	#
	# last_position = agent.global_position
	#
	# if stuck_timer >= stuck_time_threshold:
	# 	return FAILURE

	if zOnTarget and xOnTarget:
		agent.move(dir,0)
		return SUCCESS
	else:
		_rotate_agent(dir)
		agent.move(dir, speed_var)
		return RUNNING

func _rotate_agent(direction: Vector3):
	if direction.length() > 0:
		var agent_transform = agent.global_transform
		var target_rotation = agent_transform.looking_at(agent.global_position + direction, Vector3.UP).basis

		agent.transform.basis = agent.transform.basis.slerp(target_rotation, 0.1)
