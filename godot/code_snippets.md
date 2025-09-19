```
static var WINDOW = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))

RenderingServer.set_default_clear_color(Color.from_hsv(0.5, 0.5, 0.8))

label.add_theme_font_size_override("font_size", 200)
label.add_theme_color_override("font_color", Color.from_hsv(0.15, 1, 1))
label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
```

```
class_name Option
extends Node

func _ready():
	var slider = HSlider.new()
	slider.size = Vector2(200, 200)
	slider.position = Vector2(200, 100)
	slider.min_value = 0
	slider.max_value = 100
	slider.value = 50
	add_child(slider)
	slider.tick_count = 3

	var img = Image.create(64, 64, false, Image.FORMAT_RGBA8)
	img.fill(Color(1, 0, 0, 1))
	var texture = ImageTexture.new()
	texture.create_from_image(img)

	slider.add_theme_icon_override("grabber", texture)
	slider.add_theme_icon_override("grabber_highlight", texture)
	slider.add_theme_icon_override("grabber_disabled", texture)

	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color(1, 1, 0)
	slider.add_theme_stylebox_override("grabber_area_highlight", stylebox)
	slider.add_theme_stylebox_override("grabber_area", stylebox)

	img = Image.create(100, 32, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 1, 1))

	slider.add_theme_icon_override("tick", ImageTexture.create_from_image(img))

	stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color(0, 1, 0)
	stylebox.content_margin_top = 32
	
	slider.add_theme_stylebox_override("slider", stylebox)

```
