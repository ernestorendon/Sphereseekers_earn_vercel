extends StaticBody3D

@export var ground_color: Color = Color(0.5, 0.5, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		var material = StandardMaterial3D.new()
		material.albedo_color = ground_color
		child.material_override = material
		break


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
