class CustomHSlider extends HSlider:
	func _init(text: String):
		size = Vector2(300, 300)

		var label = Label.new()
		add_child(label)
		label.size = size
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.set_autowrap_mode(TextServer.AutowrapMode.AUTOWRAP_WORD)
		label.add_theme_font_size_override("font_size", 64)

		value_changed.connect(func(value):
			label.text = text + str(int(value))
		)
