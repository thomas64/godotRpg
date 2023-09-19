extends CanvasLayer


const _TEXTURE: Resource = preload("res://assets/lightmaps/fog_of_war.png")
const _ZOOM_SCALE: int = 24
const _GRID_SIZE: float = 100.0

var _blackness: Image
var _light_image: Image
var _light_offset = Vector2(_TEXTURE.get_width() / 2.0, _TEXTURE.get_height() / 2.0)


func _ready():
	$fog_image.scale = Vector2(_ZOOM_SCALE, _ZOOM_SCALE)
	_light_image = _TEXTURE.get_image()
	_light_image.convert(Image.FORMAT_RGBAH)


func on_show(tile_map: TileMap):
	if visible:
		var map_size = tile_map.get_size()
		var black_width = map_size.x / _ZOOM_SCALE
		var black_height = map_size.y / _ZOOM_SCALE
		_blackness = Image.create(black_width, black_height, false, Image.FORMAT_RGBAH)
		_blackness.fill(Color.BLACK)
		for position in Globals.history_player_positions[tile_map.get_parent().name]:
			_draw_light(position * _GRID_SIZE)


func update(map_name: String, player_position: Vector2i):
	var rounded_position: Vector2i = (player_position / _GRID_SIZE).round()
	if Globals.history_player_positions.has(map_name):
		var positions_on_map_name: Array = Globals.history_player_positions[map_name]
		if not positions_on_map_name.has(rounded_position):
			positions_on_map_name.append(rounded_position)
			Globals.history_player_positions[map_name] = positions_on_map_name
	else:
		Globals.history_player_positions[map_name] = [rounded_position]


func _draw_light(position: Vector2):
	var grid_position = position / _ZOOM_SCALE
	var light_rect = Rect2(Vector2.ZERO, Vector2(_light_image.get_width(), _light_image.get_height()))
	_blackness.blend_rect(_light_image, light_rect, grid_position - _light_offset)
	$fog_image.texture = ImageTexture.create_from_image(_blackness)

