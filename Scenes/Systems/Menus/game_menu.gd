extends Control

func _on_StartButton_pressed():
    get_tree().change_scene_to_file("res://Scenes/GameScene.tscn")

func _on_ExitButton_pressed():
    get_tree().quit()
