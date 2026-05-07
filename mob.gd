extends Area2D

var velocity = Vector2.ZERO

func _ready():
	add_to_group("mobs")
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]
	$AnimatedSprite2D.play()

func _process(delta):
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
