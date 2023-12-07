extends VBoxContainer

func _ready() -> void:
	set_sliders_texts()
	
func set_sliders_texts():
	var sens = Global.mouse_sensitivity
	$HBoxContainer/Slider.value = sens
	$HBoxContainer/Value.text = str(sens)

func _on_slider_value_changed(value: float) -> void:
	Global.mouse_sensitivity = value
	set_sliders_texts()


func _on_value_text_submitted(new_text: String) -> void:
	Global.mouse_sensitivity = float(new_text)
	set_sliders_texts()
