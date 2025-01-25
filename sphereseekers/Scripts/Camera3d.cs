using Godot;

public partial class Camera3d : Node3D
{
	[Export] public NodePath BallPath; // Path to the Ball node
	[Export] public Vector3 Offset = new Vector3(0, 3, -5); // Camera offset
	[Export] public float SmoothSpeed = 5.0f; // Smoothing factor

	private Node3D _ball;

	public override void _Ready()
	{
		if(!BallPath.IsEmpty()){
			_ball = GetNode<Node3D>(BallPathj)
		}
	}

	public override void _PhysicsProcess(double delta)
	{
		if (_ball == null) return;

		// Target position is the ball's position + offset
		Vector3 targetPosition = _ball.GlobalPosition + Offset;

		// Smoothly interpolate to the target position
		GlobalPosition = GlobalPosition.Lerp(targetPosition, (float)delta * SmoothSpeed);
	}
}
