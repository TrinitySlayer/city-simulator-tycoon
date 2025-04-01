extends CharacterBody2D

var speed = 50

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO  # Reset velocity setiap frame
	var moving = false       # Track apakah karakter bergerak

	# Horizontal movement
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		$AnimatedSprite2D.play("leftwalk")
		$AnimatedSprite2D.flip_h = true
		moving = true
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$AnimatedSprite2D.play("leftwalk")
		$AnimatedSprite2D.flip_h = false
		moving = true

	# Vertical movement
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed
		$AnimatedSprite2D.play("upwalk")
		moving = true
	elif Input.is_action_pressed("ui_down"):
		velocity.y = speed
		$AnimatedSprite2D.play("downwalk")
		moving = true

	# Pilih animasi sesuai arah yang lebih dominan
	if velocity.x != 0:
		$AnimatedSprite2D.play("leftwalk")
		$AnimatedSprite2D.flip_h = velocity.x > 0
	elif velocity.y < 0:
		$AnimatedSprite2D.play("upwalk")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("downwalk")

	# Jika tidak ada gerakan, mainkan animasi idle
	if not moving and $AnimatedSprite2D.animation != "idle animation":
		$AnimatedSprite2D.play("idle animation")

	move_and_slide()
