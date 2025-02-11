extends Node

func setLocalStorageItem(key, value):
	if OS.has_feature('web'):
		# Directly call localStorage methods without eval
		JavaScriptBridge.eval("localStorage.setItem('%s', '%s');" % [key, value])

func getLocalStorageItem(key):
	var value = "Could not find key"

	if OS.has_feature('web'):
		# Get item and check for null
		var js_result = JavaScriptBridge.eval("localStorage.getItem('%s');" % [key])
		if js_result != null:
			value = js_result
			
	return value
