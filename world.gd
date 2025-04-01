extends Node2D


func _physics_process(delta: float) -> void:
	$"carrot icon".text = ("= " + str(Global.numofcarrots))
	$"onion icon".text = ("= " + str(Global.numofonions))
