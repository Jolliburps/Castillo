extends Node

@export var mob_scene: PackedScene
var score

func _ready():
	$MobPath.curve.add_point(Vector2(0, 0))
	$MobPath.curve.add_point(Vector2(1152, 0))
	$MobPath.curve.add_point(Vector2(1152, 648))
	$MobPath.curve.add_point(Vector2(0, 648))
	$MobPath.curve.add_point(Vector2(0, 0))

func new_game():
	score = 0
	$Music.play()
	$Player.start($Start_Position.position)
	$Start_Timer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")
	get_tree().call_group("mobs", "queue_free")

func game_over():
	$Score_Timer.stop()
	$Mob_Timer.stop()
	$Music.stop()
	$Death_Sound.play()
	$HUD.show_game_over()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.velocity = velocity.rotated(direction)
	add_child(mob)

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$Mob_Timer.start()
	$Score_Timer.start()

func _on_player_hit():
	game_over()
