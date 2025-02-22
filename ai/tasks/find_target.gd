extends BTAction

@export var group: StringName
@export var target_var: StringName = &"target"

var target

func _tick(_delta: float) -> Status:
	if group == "Enemy":
		target = get_enemy_node()
	elif group == "Player":
		target = get_player_node()
	blackboard.set_var(target_var, target)
	return SUCCESS

func get_enemy_node():
	var nodes: Array[Node] = agent.get_tree().get_nodes_in_group(group)
	if nodes.size() >= 2:
		while !agent.check_for_self(nodes.front()):
			nodes.shuffle()
		return nodes.front()


func get_player_node():
	var nodes: Array[Node] = agent.get_tree().get_nodes_in_group(group)
	return nodes[0]
