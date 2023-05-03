extends PointLight2D


func _ready():
	var viewport_width: int = get_viewport().size.x
	var viewport_height: int = get_viewport().size.y
	var x_diff: float = Constant.SCREEN_WIDTH / viewport_width
	var y_diff: float = Constant.SCREEN_HEIGHT / viewport_height
	var lightmap_width: float = texture.get_size().x
	var lightmap_height: float = texture.get_size().y
	var x_scale: float = viewport_width / lightmap_width
	var y_scale: float = viewport_height / lightmap_height
	position = Vector2(viewport_width / 2.0 * x_diff, viewport_height / 2.0 * y_diff)
	scale = Vector2(x_scale * x_diff, y_scale * y_diff)

