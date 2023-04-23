extends Node2D


func _init():
	var current_map = load("res://maps/honeywood_forest_path.tscn").instantiate()
	add_child(current_map)

