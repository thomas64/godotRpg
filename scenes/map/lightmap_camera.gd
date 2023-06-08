extends PointLight2D


func _ready():
	position = Tools.get_center_screen()
	scale = Tools.calculate_scale_to_fit_screen(texture.get_size())

