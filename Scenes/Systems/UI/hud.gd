extends Control

@onready var interaction_label = $CanvasLayer/InteractLabel
@onready var clock_label = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/Time

func set_interaction_text(text: String) -> void:
	interaction_label.text = text
	interaction_label.visible = text != ""

func update_timer(time_remaining: float) -> void:
	var minutes = int(time_remaining) / 60
	var seconds = int(time_remaining) % 60
	var formatted_time = "%02d:%02d" % [minutes, seconds]

	if clock_label:
		clock_label.text = formatted_time

		# TODO: Isso não funciona
		# if time_remaining <= 10:
		# 	var color = Color(1, 0, 0, 0)
		# 	clock_label.label_settings.font_color = color