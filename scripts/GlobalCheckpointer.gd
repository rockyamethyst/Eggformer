@tool
extends Node

var checkpoint_positions = {}

func set_checkpoint(name, position):
	checkpoint_positions[name] = position

func get_checkpoint(name):
	return checkpoint_positions[name]
