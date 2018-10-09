extends KinematicBody2D
const UP = Vector2(0, -1)
const ACC = 35
const GRAVITY = 19
const SPEED = 200
const JUMP_HIGHT = -500
var motion= Vector2()
var skor
var nilai = 0
var opsi

func _ready():
	skor = get_node("../skor")
	opsi = get_node("../benar")
func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed('ui_right'):
		motion.x = min(motion.x+ACC, SPEED)
		$Sprite.flip_h = false
		$Sprite.play("jalan")
	elif Input.is_action_pressed('ui_left'):
		motion.x = max(motion.x-ACC, -SPEED)
		$Sprite.flip_h = true
		$Sprite.play("jalan")
	else:
		$Sprite.play("diam")
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed('ui_up'):
			motion.y = JUMP_HIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2) 
	else:
		if motion.y < 0:
			$Sprite.play("loncat")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	
	move_and_slide(motion, UP)
	pass

func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://arena.tscn")
	pass # replace with function body


func _on_garis1_body_entered(body):
	get_tree().change_scene("res://arena2.tscn")
	pass # replace with function body


func _on_garis2_body_entered(body):
	get_tree().change_scene("res://arena2.tscn")
	pass # replace with function body


func _on_jwbbenar_body_entered(body):
	nilai+=1
	skor.text = str(nilai)
	opsi.queue_free()
	pass # replace with function body
