extends BTAction

@export var range_min_in_dir: float = 40.0
@export var range_max_in_dir: float = 100.0

@export var position_var: StringName = &"pos"
@export var dir_var: StringName = &"dir"

func _tick(_delta: float) -> Status:
	var pos: Vector3
	var dir: Vector3 = rando_dir()

	pos = rando_pos(dir)
	blackboard.set_var(position_var, pos)

	print(dir, "   ", pos, "   agent pos: ", agent.global_position.x)
	return SUCCESS

func rando_pos(dir):
	var vector: Vector3
	var distance = randi_range(range_min_in_dir, range_max_in_dir)
	var final_position = agent.global_position + (dir * distance)
	final_position.y = agent.global_position.y

	return final_position

func rando_dir():
	var dir = Vector3(randi_range(-1,1), 0, randi_range(-1,1)).normalized()
	blackboard.set_var(dir_var, dir)
	return dir
