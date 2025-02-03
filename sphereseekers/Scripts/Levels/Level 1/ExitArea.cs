using Godot;

public partial class ExitArea : Area3D
{
	public override void _Ready()
	{
		// Connect the "body_entered" signal
		Connect("body_entered", new Callable(this, nameof(OnBodyEntered)));
	}

	private void OnBodyEntered(Node body)
	{
		GD.Print($"Node entered: {body.Name}");

		// Check if the ball entered the exit area
		if (body.Name == "Ball")
		{
			GD.Print("Level Complete!"); // Debug message

			// Stop the stopwatch
			var ui = GetNode<UI>("/root/Main/UI");
			if (ui != null)
			{
				ui.StopStopwatch();
			}
			else
			{
				GD.PrintErr("UI node not found! Make sure the path '/root/Main/UI' is correct.");
			}

			// Display level completion message
			ShowLevelCompleteMessage();

			// Load the next level
			LoadNextLevel();
		}
	}

	
	private void LoadNextLevel()
	{
		// Ensure the next level path is correct
		string nextLevelPath = "res://Scenes/Level2.tscn";
		if (!string.IsNullOrEmpty(nextLevelPath))
		{
			GD.Print($"Loading next level: {nextLevelPath}");
			GetTree().ChangeSceneToFile(nextLevelPath);
		}
		else
		{
			GD.PrintErr("Next level path is not set!");
		}
	}

	private void ShowLevelCompleteMessage()
	{
		// This method can be used to trigger level completion logic
		GD.Print("Congratulations! You completed the level!");
	}
}
