extends SceneTree

func _init():
	var input: Array
	var expected: Array

	input = [
		[1, 2, 2, 3],
		[4, 1, 2, 2],
		[4, 4, 1, 2],
		[5, 5, 5, 1],
		[6, 5, 7, 5],
	]
	expected = [
		[0, 1, 1, 0],
		[0, 0, 1, 1],
		[0, 0, 0, 1],
		[0, 0, 0, 0],
		[0, 0, 0, 0],
	]
	test(input, expected, 5)

static func find_large_groups(input: Array, find_threshold: int) -> Array:
	var size = Vector2(input[0].size(), input.size())
	var visited = []
	var result = []
	for y in range(size.y):
		visited.append([])
		result.append([])
		for x in range(size.x):
			visited[y].append(false)
			result[y].append(0)

	var directions = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]

	for y in range(size.y):
		for x in range(size.x):
			if not visited[y][x]:
				var stack = [Vector2(x, y)]
				var group = []
				var value = input[y][x]
				while stack.size() > 0:
					var pos = stack.pop_back()
					if visited[pos.y][pos.x]:
						continue
					visited[pos.y][pos.x] = true
					group.append(pos)
					for dir in directions:
						var new_pos = pos + dir
						if new_pos.x >= 0 and new_pos.x < size.x and new_pos.y >= 0 and new_pos.y < size.y:
							if input[new_pos.y][new_pos.x] == value and not visited[new_pos.y][new_pos.x]:
								stack.append(new_pos)
				if group.size() >= find_threshold:
					for pos in group:
						result[pos.y][pos.x] = 1

	return result


static func test(input: Array, expected: Array, find_threshold: int) -> void:
	var result = find_large_groups(input, find_threshold)

	var size = Vector2(input[0].size(), input.size())
	var error_count = 0
	for y in range(size.y):
		var row_str = ""
		for x in range(size.x):
			row_str += str(input[y][x]) + " " + str(expected[y][x]) + " " + str(result[y][x])
			if expected[y][x] != result[y][x]:
				row_str += " X"
				error_count += 1
			else:
				row_str += " O"
			row_str += " | "
		print(row_str)
	print("Errors: " + str(error_count))
