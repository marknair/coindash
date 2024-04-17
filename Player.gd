extends Area2D
signal pickup
signal hurt

@export var speed: int = 350
var velocity = Vector2.ZERO
var screensize = Vector2(480, 720)

func start():
	set_process(true)
	position = screensize / 2
	$AnimatedSprite2D.animation = "idle"

func _ready():
	pass # Replace with function body.

func _process(delta):
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity * speed * delta
	position.x = clamp(position.x, 15, screensize.x - 15)
	position.y = clamp(position.y, 15, screensize.y - 15)
	
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)


func _on_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit()
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()
