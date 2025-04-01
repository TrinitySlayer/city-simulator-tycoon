extends StaticBody2D

var plant = Global.plantselected
var plantgrowing = false
var plant_grown = false

func _physics_process(delta):
	if not plantgrowing:
		plant = Global.plantselected  # Update pilihan pemain jika ada perubahan

# Fungsi untuk menangani saat area 2D masuk
func _on_area_2d_area_entered(area: Area2D) -> void:
	if not plantgrowing:
		if plant == 1:  # Carrot
			plantgrowing = true
			$"carrot growing".start()  # Memulai animasi untuk tumbuh wortel
			$plant.play("carrotgrowing")  # Pastikan animasi ini ada dan benar
		elif plant == 2:  # Onion
			plantgrowing = true
			$"onion growing".start()  # Memulai animasi untuk tumbuh bawang
			$plant.play("oniongrowing")  # Pastikan animasi ini ada dan benar
		else:
			print("Error: plant tidak valid!", plant)
	else:
		print("Plant already growing here")

# Fungsi untuk menangani tumbuhnya wortel
func _on_carrot_growing_timeout() -> void:
	if $plant.frame == 0:
		$plant.frame = 1
		if $CarrotTimer:  # Pastikan timer wortel ada di scene
			$CarrotTimer.start()
	elif $plant.frame == 1:
		$plant.frame = 2
		plant_grown = true  # Menandakan wortel sudah matang dan bisa dipanen

# Fungsi untuk menangani tumbuhnya bawang
func _on_onion_growing_timeout() -> void:
	if $plant.frame == 0:
		$plant.frame = 1
		if $OnionTimer:  # Pastikan timer bawang ada di scene
			$OnionTimer.start()
	elif $plant.frame == 1:
		$plant.frame = 2
		plant_grown = true  # Menandakan bawang sudah matang dan bisa dipanen

# Fungsi untuk menangani input klik pada area 2D
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if plant_grown:
			if plant == 1:  # Carrot
				Global.numofcarrots += 1
			elif plant == 2:  # Onion
				Global.numofonions += 1
			else:
				print("Error: plant tidak valid!", plant)
				return

			# Setelah dipanen, reset status tanaman dan sembunyikan animasi
			plantgrowing = false
			plant_grown = false
			$plant.stop()  # Menghentikan animasi jika tidak ada animasi 'none'

			# Opsional: Hapus atau sembunyikan sprite tanaman yang sudah dipanen
			$plant.queue_free()  # Menghapus node dari scene, atau gunakan $plant.visible = false untuk menyembunyikan sprite
