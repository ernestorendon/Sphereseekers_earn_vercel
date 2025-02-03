using Godot;

public partial class Hole1 : Area3D
{
	private RigidBody3D _ball; // Reference to the ball
	private Vector3 _resetPosition = new Vector3(-2.252f, 2f, -14.11f); // Starting position

	public override void _Ready()
	{
		// Find the ball in the scene
		_ball = GetNode<RigidBody3D>("/root/Main/Ball"); // Update path if necessary
		Connect("body_entered", new Callable(this, nameof(OnBodyEntered)));
	}

	private void OnBodyEntered(Node body)
	{
		// Check if the ball entered the reset area
		if (body.Name == "Ball")
		{
			GD.Print("Ball entered the reset area! Resetting...");
			ResetBall();
		}
	}

	private void ResetBall()
	{
		// Reset the ball's position to the starting point
		_ball.GlobalPosition = _resetPosition;
		_ball.LinearVelocity = Vector3.Zero; // Stop ball movement
		_ball.AngularVelocity = Vector3.Zero; // Stop ball rotation
	}
}
