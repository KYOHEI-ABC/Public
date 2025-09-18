class_name CustomSlider
extends HSlider

func _init(text: String, min_value: float, max_value: float, step: float, initial_value: float = 0):
	self.value = initial_value
	self.min_value = min_value
	self.max_value = max_value
	self.step = step
	self.size = Vector2(400, 240)

	label = Label.new()
	label.size = Vector2(800, 240)
	label.position = Vector2(-800 / 4, 0)
	label.text = text + ": " + str(int(self.value))
	label.add_theme_font_size_override("font_size", 50)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	add_child(label)


	self.value_changed.connect(func(value: float) -> void:
		label.text = text + ": " + str(int(value))
	)
