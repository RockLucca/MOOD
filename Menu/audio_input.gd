extends VBoxContainer

@export var audio_channel_name = "Master"
@onready var audio_channel = AudioServer.get_bus_index(audio_channel_name)

func _ready() -> void:
	set_sliders_texts()

func get_linear_volume():
	var volume = db_to_linear(AudioServer.get_bus_volume_db(audio_channel)) * 100
	if volume > 100:
		volume = 100
	return volume
	
func set_linear_volume(audio_server, volume):
	AudioServer.set_bus_volume_db(audio_server, linear_to_db(volume/100))
	
func set_sliders_texts():
	var volume = get_linear_volume()
	$HBoxContainer/Slider.value = volume
	$HBoxContainer/Value.text = str(volume)

func _on_slider_value_changed(value: float) -> void:
	set_linear_volume(audio_channel, value)
	set_sliders_texts()

func _on_value_text_submitted(new_text: String) -> void:
	set_linear_volume(audio_channel, float(new_text))
	set_sliders_texts()
