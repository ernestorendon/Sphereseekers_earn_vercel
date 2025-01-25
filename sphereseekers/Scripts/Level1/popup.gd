extends CanvasLayer

func _ready():
	
	# set visibility
	$ControlsPanel.visible = true

	# Check VBoxContainer
	var vbox = $ControlsPanel/VBoxContainer
	if vbox:
		
		if vbox.has_node("ContinueButton"):
			var continue_btn = vbox.get_node("ContinueButton")
			continue_btn.text = "Continue"
			
func _on_continue_pressed():
	$ControlsPanel.visible = false
