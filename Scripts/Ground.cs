using Godot;

public partial class Ground : StaticBody3D
{
	public override void _Ready()
	{
		// Get the PlaneMesh size
		var meshInstance = GetNode<MeshInstance3D>("MeshInstance3D");
		var planeSize = ((PlaneMesh)meshInstance.Mesh).Size;

		// Update the CollisionShape3D size
		var collisionShape = GetNode<CollisionShape3D>("CollisionShape3D");
		var boxShape = (BoxShape3D)collisionShape.Shape;

		boxShape.Size = new Vector3(planeSize.X, 1, planeSize.Y); // Match size
	}
}
