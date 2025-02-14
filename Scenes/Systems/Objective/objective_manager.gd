extends Node3D

var objectives = []

func _ready():
    objectives = get_children()

func check_all_objectives():
    for objective in objectives:
        if not objective.is_completed:
            return false
    print("All objectives completed!")
    return true
