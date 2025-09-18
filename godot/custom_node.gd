class CustomNode2D extends Node2D:
	var value: int
	var size: Vector2


static func get_colliding_node(custom_node: CustomNode2D, custom_nodes: Array[CustomNode2D]) -> CustomNode2D:
	var rect_a = Rect2(custom_node.position - custom_node.size * 0.5, custom_node.size)
	for other_node in custom_nodes:
		if other_node == custom_node:
			continue
		var rect_b = Rect2(other_node.position - other_node.size * 0.5, other_node.size)
		if rect_a.intersects(rect_b):
			return other_node
	return null


static func move(custom_node: CustomNode2D, delta: Vector2, custom_nodes: Array[CustomNode2D]) -> Vector2:
	var original_position = custom_node.position
	custom_node.position += delta

	var colliding_node = null
	colliding_node = get_colliding_node(custom_node, custom_nodes)
	if colliding_node == null:
		return custom_node.position - original_position

	var dy = custom_node.position.y - colliding_node.position.y
	if dy > 0:
		custom_node.position.y = colliding_node.position.y + (colliding_node.size.y + custom_node.size.y) * 0.5
	elif dy < 0:
		custom_node.position.y = colliding_node.position.y - (colliding_node.size.y + custom_node.size.y) * 0.5
	
	colliding_node = get_colliding_node(custom_node, custom_nodes)
	if colliding_node == null:
		return custom_node.position - original_position

	custom_node.position = original_position
	return custom_node.position - original_position
