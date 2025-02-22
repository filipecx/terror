extends Control
class_name FeedbackUI

@onready var label = $FeedbackLabel

func show_message(text: String, duration: float = 2.0):
	label.text = text
	label.visible = true
	$Timer.start(duration)  # Start timer to hide message

func _on_timer_timeout():
	print("Timer timeout")
	label.visible = false
