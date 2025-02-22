extends BTAction

@export var target_var := &"target"

@export var speed_var = 60;
@export var tolerance = 20;

func _tick(_delta: float) -> Status:
	var target: CharacterBody3D = blackboard.get_var(target_var)
	if target == null:
		return FAILURE

	var target_position = target.global_position
	var dir: Vector3 = agent.global_position.direction_to(target_position)

	var zOnTarget = abs(agent.global_position.z - target_position.z) < tolerance
	var xOnTarget = abs(agent.global_position.x - target_position.x) < tolerance

	if zOnTarget and xOnTarget:
		agent.move(dir,0)
		return SUCCESS
	else:
		# _rotate_agent(dir)
		agent.move(dir, speed_var)
		return RUNNING

