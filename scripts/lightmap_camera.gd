extends PointLight2D


func _ready():
	var viewportWidth: int = get_viewport().size.x
	var viewportHeight: int = get_viewport().size.y
	var x_scale: float = viewportWidth / texture.get_size().x
	var y_scale: float = viewportHeight / texture.get_size().y
	position = Vector2(viewportWidth / 2, viewportHeight / 2)
	scale = Vector2(x_scale, y_scale)
