extends StaticBody2D

var plant = Global.plantselected
var plantgrowing = false
var plant_grown = false

func _physics_process(delta):
	if not plantgrowing:
		plant = Global.plantselected  # Update pilihan pemain

func _on_area_2d_area_entered(area):
	if not plantgrowing:
		if plant == 1:
			plantgrowing = true
			$"carrot growing".start()
			$plant.play("carrotgrowing")  # Perbaiki animasi jika perlu (gunakan nama animasi yang benar)
		elif plant == 2:
			plantgrowing = true
			$"onion growing".start()
			$plant.play("oniongrowing")
	else:
		print("Plant already growing here")

# Fungsi untuk menangani tumbuhnya wortel
func _on_carrot_growing_timeout() -> void:
	if $plant.frame == 0:
		$plant.frame = 1
		if $CarrotTimer:  # Pastikan timer sudah ada dalam scene
			$CarrotTimer.start()
	elif $plant.frame == 1:
		$plant.frame = 2
		plant_grown = true

# Fungsi untuk menangani tumbuhnya bawang
func _on_onion_growing_timeout() -> void:
	if $plant.frame == 0:
		$plant.frame = 1
		if $OnionTimer:  # Pastikan timer sudah ada dalam scene
			$OnionTimer.start()
	elif $plant.frame == 1:
		$plant.frame = 2
		plant_grown = true

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if plant_grown:
			if plant == 1:
				Global.numofcarrots += 1
			elif plant == 2:
				Global.numofonions += 1
			else:
				print("Error: plant tidak valid!", plant)
				return

			# Setelah dipanen, reset status tanaman dan sembunyikan animasi
			plantgrowing = false
			plant_grown = false
			$plant.stop()  # Menghentikan animasi jika tidak ada animasi 'none'

			# Opsional: Hapus atau sembunyikan sprite tanaman yang sudah dipanen
			$plant.queue_free()  # Hapus node dari scene atau gunakan $plant.visible = false untuk menyembunyikan sprite
