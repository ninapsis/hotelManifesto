extends Node2D

const SlotClass = preload("res://UI/Slot.gd")

onready var inventory_slots = $GridContainer
var holding_item = null

func _ready():
	pass
