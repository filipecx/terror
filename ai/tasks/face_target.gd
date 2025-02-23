@tool
extends BTAction
@export var target_var: StringName = &"target"

func _generate_name() -> String:
	return "FaceTarget " + LimboUtility.decorate_var(target_var)

func _tick(delta: float) -> Status:
	var target: CharacterBody3D = blackboard.get_var(target_var)
	if not is_instance_valid(target):
		return FAILURE
	var dir: Vector3 = target.global_position - agent.global_position
	agent.velocity = Vector3.ZERO
	agent._rotate_towards(dir, delta)
	return SUCCESS
