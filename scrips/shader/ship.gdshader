shader_type canvas_item;

uniform vec4 target_color: source_color;
uniform vec4 new_color: source_color;

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);

	if(pixel_color.rgba == target_color.rgba) {
		COLOR = new_color;
	}
}