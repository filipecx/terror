extends BTCondition

@export var stuck_time: float = 3.0
var last_position: Vector3
var timer: float = 0.0

func _tick(_delta: float) -> Status:
	var current_position = agent.global_transform.origin
	if last_position.distance_to(current_position) < 0.1:
		timer += _delta
		if timer >= stuck_time:
			return SUCCESS

		last_position = current_position
		return RUNNING
	timer = 0.0
	return FAILURE
