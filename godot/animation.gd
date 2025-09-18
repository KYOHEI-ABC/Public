extends SceneTree

static var WINDOW = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))

class InputForTest extends Node:
	signal sig(str: String)
	func _input(event):
		if event is InputEventScreenTouch and event.pressed:
			emit_signal("sig", "play")
		if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
			emit_signal("sig", "pause")


static var tweens: Array[Tween] = []

func _init():
	var node = Node2D.new()
	get_root().add_child(node)
	var sprite = Sprite2D.new()
	node.add_child(sprite)
	sprite.texture = load("res://assets/square.png")
	node.position = WINDOW * 0.5
	node.scale = Vector2(100, 100) / sprite.texture.get_size()

	var input_for_test = InputForTest.new()
	get_root().add_child(input_for_test)
	input_for_test.sig.connect(func(str):
		if str == "play":
			rotation(tweens, sprite, 3, 2.0)
			jump(tweens, sprite, Vector2(0, -100), 2.0)
		if str == "pause":
			pause_resume_tween(tweens)
	)

static func fade(tweens: Array[Tween], root: Node, time: float) -> void:
	var canvas = CanvasLayer.new()
	root.add_child(canvas)
	var color_rect = ColorRect.new()
	canvas.add_child(color_rect)
	if time < 0:
		color_rect.color = Color(0, 0, 0, 0)
	else:
		color_rect.color = Color(0, 0, 0, 1)
	color_rect.size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
	var tween = color_rect.get_tree().create_tween()
	tweens.append(tween)
	if time < 0:
		tween.tween_property(color_rect, "color:a", 1.0, abs(time))
	else:
		tween.tween_property(color_rect, "color:a", 0.0, abs(time))
	await tween.finished
	tween.kill()
	tweens.erase(tween)
	canvas.queue_free()


static func pause_resume_tween(tweens: Array[Tween]):
	for tween in tweens:
		if tween.is_valid():
			if tween.is_running():
				tween.pause()
			else:
				tween.play()

static func rotation(tweens: Array[Tween], sprite: Sprite2D, count: int, time: float) -> void:
	if sprite.rotation != 0:
		return
	var tween = sprite.get_tree().create_tween()
	tweens.append(tween)
	tween.tween_property(sprite, "rotation", TAU * count, time)
	await tween.finished
	sprite.rotation = 0
	tween.kill()
	tweens.erase(tween)

static func jump(tweens: Array[Tween], sprite: Sprite2D, delta: Vector2, time: float):
	if sprite.position != Vector2.ZERO:
		return
	var tween = sprite.get_tree().create_tween()
	tweens.append(tween)
	tween.tween_property(sprite, "position", delta, time * 0.5)
	tween.tween_property(sprite, "position", Vector2.ZERO, time * 0.5)
	await tween.finished
	tween.kill()
	tweens.erase(tween)