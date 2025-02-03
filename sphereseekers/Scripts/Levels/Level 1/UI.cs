using Godot;
using System;

public partial class UI : CanvasLayer
{
	private Label _stopwatchLabel;
	private Label _bestTimeLabel;

	private float _elapsedTime = 0f; // Current time in seconds
	private float _bestTime = float.MaxValue; // Best time, initialized to a high value

	private bool _isRunning = true;

	public override void _Ready()
	{
		// Get the labels
		_stopwatchLabel = GetNode<Label>("StopwatchLabel");
		_bestTimeLabel = GetNode<Label>("BestTimeLabel");

		// Initialize labels
		_stopwatchLabel.Text = "00:00";
		UpdateBestTimeText(); // Show initial best time as "--:--"
	}

	public override void _Process(double delta)
	{
		if (_isRunning)
		{
			// Increment elapsed time
			_elapsedTime += (float)delta;

			// Update the stopwatch display
			UpdateStopwatchText();
		}
	}

	private void UpdateStopwatchText()
	{
		// Format the elapsed time as MM:SS
		int minutes = (int)(_elapsedTime / 60);
		int seconds = (int)(_elapsedTime % 60);

		_stopwatchLabel.Text = $"{minutes:D2}:{seconds:D2}";
	}

	public void StopStopwatch()
	{
		// Stop the stopwatch when the player beats the level
		_isRunning = false;

		// Check if the current time is better than the best time
		if (_elapsedTime < _bestTime)
		{
			_bestTime = _elapsedTime; // Update the best time
			UpdateBestTimeText(); // Refresh the label
		}

		// Restart the timer for the next level
		ResetStopwatch(true);
	}

	public void ResetStopwatch(bool levelComplete)
	{
		if (levelComplete)
		{
			// Reset the timer only when the level is completed
			_elapsedTime = 0f;
		}

		_isRunning = true;

		// Update the stopwatch text
		UpdateStopwatchText();
	}

	private void UpdateBestTimeText()
	{
		if (_bestTime == float.MaxValue)
		{
			// No best time yet
			_bestTimeLabel.Text = "Best: --:--";
		}
		else
		{
			// Format the best time as MM:SS
			int minutes = (int)(_bestTime / 60);
			int seconds = (int)(_bestTime % 60);

			_bestTimeLabel.Text = $"Best: {minutes:D2}:{seconds:D2}";
		}
	}

	public void HandleBallReset(bool fellOffGround)
	{
		if (fellOffGround)
		{
			// Ball fell off the ground, treat it as a level completion
			StopStopwatch();
		}
		else
		{
			// Ball fell into a hole, do not reset the timer
			GD.Print("Ball reset, but timer continues.");
		}
	}
}
