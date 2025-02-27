extends Area3D

var tween = Tween
# Called when a body enters the Area3D
func _on_body_entered(body):
	if body.is_in_group("player"):
		
		if body.has_method("disable_controls"):
			body.disable_controls()
		
		var platform_center = global_transform.origin
		var target_position = platform_center + Vector3(0, 2.0, 0)
		tween = get_tree().create_tween()
		tween.tween_property(body, "position", target_position, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_callback(_on_animation_complete)

func _on_animation_complete():
	print("Player moved to center and elevated. Level Finished.")
	get_tree().paused = true
