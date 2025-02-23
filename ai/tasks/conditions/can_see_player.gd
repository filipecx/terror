extends BTCondition

func _tick(_delta: float) -> Status:
	var vision_area = agent.get_node("VisionArea")
	if vision_area and vision_area.player:
		return SUCCESS
	return FAILURE
