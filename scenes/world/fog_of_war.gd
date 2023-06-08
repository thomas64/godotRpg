extends CanvasLayer


const _TEXTURE = preload("res://assets/lightmaps/fog_of_war.png")
const _GRID_SIZE = 24

var _blackness: Image
var _light_image: Image


func _ready():
	$fog_image.scale = Vector2(_GRID_SIZE, _GRID_SIZE)
	_light_image = _TEXTURE.get_image()
	_light_image.convert(Image.FORMAT_RGBAH)


func on_show(tile_map: TileMap):
	if visible:
		var map_size = tile_map.get_size()
		var black_width = map_size.x / _GRID_SIZE
		var black_height = map_size.y / _GRID_SIZE
		_blackness = Image.create(black_width, black_height, false, Image.FORMAT_RGBAH)
		_blackness.fill(Color.BLACK)

		# for each of the positions from the container out of tile_map -> draw_light(position)
#		var player_position = get_parent().get_parent().get_children().front().get_node("player").position
#		_draw_light(player_position)


func _draw_light(position: Vector2):
	var grid_position = position / _GRID_SIZE
	var light_rect = Rect2(Vector2.ZERO, Vector2(_light_image.get_width(), _light_image.get_height()))
	var light_offset = Vector2(_TEXTURE.get_width() / 2.0, _TEXTURE.get_height() / 2.0)

	_blackness.blend_rect(_light_image, light_rect, grid_position - light_offset)
	$fog_image.texture = ImageTexture.create_from_image(_blackness)

