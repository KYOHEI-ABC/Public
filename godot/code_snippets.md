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
```
static func find_large_groups(input: Array, find_threshold: int) -> Array:
	var size = Vector2(input[0].size(), input.size())
	var result = create_2d_array(size, 0)
	var visited = create_2d_array(size, false)

	var directions = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]

	for y in range(size.y):
		for x in range(size.x):
			var stack: Array[Vector2] = [Vector2(x, y)]
			var group: Array[Vector2] = []

			while stack.size() > 0:
				var pos = stack.pop_back()
				visited[pos.y][pos.x] = true
				group.append(pos)

				for dir in directions:
					var new_pos = pos + dir

					if out_of_bounds(new_pos, size):
						continue

					if visited[new_pos.y][new_pos.x]:
						continue

					if input[new_pos.y][new_pos.x] == input[y][x]:
						stack.append(new_pos)

			if group.size() >= find_threshold:
				for pos in group:
					result[pos.y][pos.x] = 1

	return result
```
