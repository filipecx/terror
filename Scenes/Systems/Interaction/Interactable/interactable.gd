extends Area3D

class_name Interactable

# Signals to emmit when the interactor enters or exits the area
signal focused(interactor: Interactor)
signal unfocused(interactor: Interactor)
signal interacted(interactor: Interactor)

