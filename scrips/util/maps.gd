class_name Maps

static func fill_map(map: TileMapLayer, x_range: Array, y_range: Array):
    var tiles: Array[Vector2i] = []

    for x in x_range:
        for y in y_range:
            tiles.push_back(Vector2i(x, y))

    map.set_cells_terrain_connect(tiles, 0, 0)
