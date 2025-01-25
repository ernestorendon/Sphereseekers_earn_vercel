using Godot;
using System;

public partial class BallController : RigidBody3D
{
	[Export] public float Speed = 20.0f; // Ball speed multiplier
	private Vector3 _startPosition;      // Stores the ball's starting position

	public override void _Ready()
	{
		// Save the starting position when the scene loads
		_startPosition = Position;
	}

	public override void _PhysicsProcess(double delta)
	{
		Vector3 inputDirection = Vector3.Zero;

		// Map arrow key inputs to ball movement
		if (Input.IsKeyPressed(Key.W) || Input.IsKeyPressed(Key.Up)) inputDirection.Z -= 1; // Forward
		if (Input.IsKeyPressed(Key.S) || Input.IsKeyPressed(Key.Down)) inputDirection.Z += 1; // Backward
		if (Input.IsKeyPressed(Key.A) || Input.IsKeyPressed(Key.Left)) inputDirection.X -= 1; // Left
		if (Input.IsKeyPressed(Key.D) || Input.IsKeyPressed(Key.Right)) inputDirection.X += 1; // Right

		// Apply force to move the ball
		ApplyCentralForce(inputDirection.Normalized() * Speed);

		// Reset the ball if it falls below a certain height
		if (Position.Y < -5)
		{
			GD.Print("Ball fell off the ground. Resetting position.");
			Position = _startPosition; // Reset position to the start
			LinearVelocity = Vector3.Zero; // Stop movement
			AngularVelocity = Vector3.Zero; // Stop rotation
		}
		
	}

	public override void _IntegrateForces(PhysicsDirectBodyState3D state)
	{
		// Debugging: Check for collisions with the ground
		if (state.GetContactCount() > 0)
		{
			GD.Print("Ball is colliding with the ground.");
		}
	}
}
