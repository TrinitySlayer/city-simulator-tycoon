extends Node

var plantselected = 1  # 1 = Carrot, 2 = Onion, 3 = Tomato (contoh)
var numofcarrots = 0
var numofonions = 0

func set_plant_selected(value: int) -> void:
	if value in [1, 2, 3]:  
		plantselected = value
	else:
		print("Error: Pilihan tanaman tidak valid!")
