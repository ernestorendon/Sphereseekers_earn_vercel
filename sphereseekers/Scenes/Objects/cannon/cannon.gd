extends Node3D

@export var cylinder_position: Vector3 = Vector3(0, 0, 0)
@export var shoot_distance: float = 10.0
@export var speed: float = 20.0
@export var shoot_delay: float = 0.5
@export var cylinder_radius: float = 5
@export var scale_factor: float = 1.0
@export var cannon_material: StandardMaterial3D
@export var projectile_material: StandardMaterial3D
@export var rotate: bool = false

var direction: Vector3 = Vector3.RIGHT
var is_shooting: bool = false

func _ready() -> void:
	apply_scaling()

	start_shooting()

func apply_scaling():
	var scaled_radius = cylinder_radius * scale_factor

	var cylinder = $structure
	cylinder.position = cylinder_position
	cylinder.radius = scaled_radius
	cylinder.height = scaled_radius
	cylinder.material = cannon_material

	var hole = $structure/hole
	hole.position = cylinder_position
	hole.radius = scaled_radius * 0.9
	hole.height = scaled_radius * 1.1
	hole.material = cannon_material

func start_shooting():
	is_shooting = true
	spawn_and_shoot_sphere()

func spawn_and_shoot_sphere():
	var sphere_body = RigidBody3D.new()
	sphere_body.position = cylinder_position
	add_child(sphere_body)

	var sphere_mesh = MeshInstance3D.new()
	var sphere_shape = SphereMesh.new()

	var sphere_radius = (cylinder_radius * 0.9) * scale_factor
	sphere_shape.radius = sphere_radius
	sphere_shape.height = sphere_radius * 2
	sphere_mesh.mesh = sphere_shape
	sphere_body.add_child(sphere_mesh)

	sphere_mesh.set_surface_override_material(0, projectile_material)

	var collision_shape = CollisionShape3D.new()
	var sphere_collision = SphereShape3D.new()
	sphere_collision.radius = sphere_radius
	collision_shape.shape = sphere_collision
	sphere_body.add_child(collision_shape)

	sphere_body.add_to_group("enemy_balls")

	move_sphere(sphere_body)

func move_sphere(sphere: RigidBody3D):
	var distance_traveled = 0.0
	var rotation_speed = 5.0
	
	while distance_traveled < shoot_distance:
		if not is_instance_valid(sphere) or not is_inside_tree():
			return
			
		while Global.is_paused:
			if not get_tree() or not is_inside_tree():
				return
			await get_tree().process_frame 

		if not get_tree():
			return

		await get_tree().process_frame
		var delta_time = get_process_delta_time()
		
		sphere.position += direction * speed * delta_time
		distance_traveled += speed * delta_time
		
		if rotate:
			sphere.rotate_z(deg_to_rad(rotation_speed * delta_time * -50))

	if is_instance_valid(sphere):
		sphere.queue_free()

	await get_tree().create_timer(shoot_delay).timeout

	if is_inside_tree():
		spawn_and_shoot_sphere()
