#pragma header

uniform vec4 target;
uniform vec4 replacement;
uniform bool on;

void main()
{
	vec4 color = texture2D(bitmap, openfl_TextureCoordv);

	if (on && color.rgba == target.rgba)
	{
		color.rgba = replacement;
	}

	gl_FragColor = color;
}
