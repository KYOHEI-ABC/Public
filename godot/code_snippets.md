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
```
extends SceneTree

class Array2D:
	static func new_array_2d(size: Vector2, default_value) -> Array:
		var array_2d: Array = []
		for y in range(size.y):
			var row: Array = []
			for x in range(size.x):
				row.append(default_value)
			array_2d.append(row)
		return array_2d

	static func print_array_2d(array_2d: Array) -> void:
		for row in array_2d:
			print(row)
		print("")

	static func out_of_bounds(pos: Vector2, array_2d: Array) -> bool:
		if pos.x < 0 or pos.y < 0:
			return true
		if pos.x >= array_2d[0].size() or pos.y >= array_2d.size():
			return true
		return false

	static func get_size(array_2d: Array) -> Vector2:
		return Vector2(array_2d[0].size(), array_2d.size())

	static func get_value(array_2d: Array, position: Vector2):
		return array_2d[position.y][position.x]
	static func set_value(array_2d: Array, position: Vector2, value) -> void:
		array_2d[position.y][position.x] = value

	static func get_position(array_2d: Array, value) -> Vector2:
		for y in range(array_2d.size()):
			for x in range(array_2d[0].size()):
				if array_2d[y][x] == value:
					return Vector2(x, y)
		return Vector2(-1, -1)

	static func warp_position(array_2d: Array, position: Vector2) -> Vector2:
		var size = get_size(array_2d)
		if position.x < 0:
			position.x = size.x - 1
		if position.x >= size.x:
			position.x = 0
		if position.y < 0:
			position.y = size.y - 1
		if position.y >= size.y:
			position.y = 0
		return position

	static func move_value(array_2d: Array, value, delta: Vector2) -> bool:
		var initial_position = get_position(array_2d, value)
		var old_position = initial_position
		var new_position: Vector2
		for i in range(max(array_2d.size(), array_2d[0].size())):
			new_position = warp_position(array_2d, old_position + delta)
			if get_value(array_2d, new_position) == -1:
				set_value(array_2d, initial_position, -1)
				set_value(array_2d, new_position, value)
				return true
			old_position = new_position

		return false
		
	static func vector2_to_value(array_2d: Array, vector2: Vector2) -> int:
		var size = get_size(array_2d)
		return int(vector2.y) * int(size.x) + int(vector2.x)
	static func value_to_vector2(array_2d: Array, value: int) -> Vector2:
		var size = get_size(array_2d)
		var x = value % int(size.x)
		var y = value / int(size.x)
		return Vector2(x, y)

func _init():
	var array_2d = Array2D.new_array_2d(Vector2(3, 4), -1)

	assert(Array2D.get_size(array_2d) == Vector2(3, 4))

	assert(Array2D.out_of_bounds(Vector2(-1, 0), array_2d) == true)
	assert(Array2D.out_of_bounds(Vector2(0, -1), array_2d) == true)
	assert(Array2D.out_of_bounds(Vector2(2, 3), array_2d) == false)
	assert(Array2D.out_of_bounds(Vector2(3, 3), array_2d) == true)
	assert(Array2D.out_of_bounds(Vector2(2, 4), array_2d) == true)

	Array2D.set_value(array_2d, Vector2(0, 0), 5)
	Array2D.set_value(array_2d, Vector2(2, 3), 10)

	assert(Array2D.get_value(array_2d, Vector2(0, 0)) == 5)
	assert(Array2D.get_value(array_2d, Vector2(2, 3)) == 10)
	assert(Array2D.get_value(array_2d, Vector2(1, 1)) == -1)

	assert(Array2D.get_position(array_2d, 5) == Vector2(0, 0))
	assert(Array2D.get_position(array_2d, 10) == Vector2(2, 3))
	assert(Array2D.get_position(array_2d, 100) == Vector2(-1, -1))

	assert(Array2D.warp_position(array_2d, Vector2(0, 0)) == Vector2(0, 0))
	assert(Array2D.warp_position(array_2d, Vector2(2, 3)) == Vector2(2, 3))
	assert(Array2D.warp_position(array_2d, Vector2(3, 3)) == Vector2(0, 3))
	assert(Array2D.warp_position(array_2d, Vector2(2, 4)) == Vector2(2, 0))

	assert(Array2D.move_value(array_2d, 5, Vector2(1, 0)) == true)
	assert(Array2D.move_value(array_2d, 10, Vector2(-1, 0)) == true)
	assert(Array2D.move_value(array_2d, 10, Vector2(0, 1)) == true)

	Array2D.set_value(array_2d, Vector2(1, 2), 20)
	assert(Array2D.move_value(array_2d, 20, Vector2(0, -1)) == true)
	assert(Array2D.get_position(array_2d, 20) == Vector2(1, 3))

	assert(Array2D.move_value(array_2d, 20, Vector2(0, 1)) == true)
	assert(Array2D.get_position(array_2d, 20) == Vector2(1, 2))

	assert(Array2D.move_value(array_2d, 20, Vector2(0, 1)) == true)
	assert(Array2D.get_position(array_2d, 20) == Vector2(1, 3))

	Array2D.set_value(array_2d, Vector2(1, 2), 30)

	assert(Array2D.move_value(array_2d, 30, Vector2(0, 1)) == false)
	assert(Array2D.get_value(array_2d, Vector2(1, 2)) == 30)

	assert(Array2D.move_value(array_2d, 30, Vector2(0, -1)) == false)
	assert(Array2D.get_value(array_2d, Vector2(1, 2)) == 30)

	assert(Array2D.move_value(array_2d, 30, Vector2(-1, 0)) == true)
	assert(Array2D.get_position(array_2d, 30) == Vector2(0, 2))

	assert(Array2D.vector2_to_value(array_2d, Vector2(0, 0)) == 0)
	assert(Array2D.vector2_to_value(array_2d, Vector2(1, 0)) == 1)
	assert(Array2D.vector2_to_value(array_2d, Vector2(2, 0)) == 2)
	assert(Array2D.vector2_to_value(array_2d, Vector2(0, 1)) == 3)
	assert(Array2D.vector2_to_value(array_2d, Vector2(1, 1)) == 4)
	assert(Array2D.vector2_to_value(array_2d, Vector2(2, 1)) == 5)
	assert(Array2D.vector2_to_value(array_2d, Vector2(0, 2)) == 6)
	assert(Array2D.vector2_to_value(array_2d, Vector2(1, 2)) == 7)
	assert(Array2D.vector2_to_value(array_2d, Vector2(2, 2)) == 8)
	assert(Array2D.vector2_to_value(array_2d, Vector2(0, 3)) == 9)
	assert(Array2D.vector2_to_value(array_2d, Vector2(1, 3)) == 10)
	assert(Array2D.vector2_to_value(array_2d, Vector2(2, 3)) == 11)

	assert(Array2D.value_to_vector2(array_2d, 0) == Vector2(0, 0))
	assert(Array2D.value_to_vector2(array_2d, 1) == Vector2(1, 0))
	assert(Array2D.value_to_vector2(array_2d, 2) == Vector2(2, 0))
	assert(Array2D.value_to_vector2(array_2d, 3) == Vector2(0, 1))
	assert(Array2D.value_to_vector2(array_2d, 4) == Vector2(1, 1))
	assert(Array2D.value_to_vector2(array_2d, 5) == Vector2(2, 1))
	assert(Array2D.value_to_vector2(array_2d, 6) == Vector2(0, 2))
	assert(Array2D.value_to_vector2(array_2d, 7) == Vector2(1, 2))
	assert(Array2D.value_to_vector2(array_2d, 8) == Vector2(2, 2))
	assert(Array2D.value_to_vector2(array_2d, 9) == Vector2(0, 3))
	assert(Array2D.value_to_vector2(array_2d, 10) == Vector2(1, 3))
	assert(Array2D.value_to_vector2(array_2d, 11) == Vector2(2, 3))
```
