#pragma header

uniform vec3 target;
uniform vec3 replacement;
uniform bool on;

void main()
{
	vec4 color = texture2D(bitmap, openfl_TextureCoordv);

	if (on && color.rgb == target.rgb && color.a > 0)
	{
		color.rgb = replacement;
	}

	gl_FragColor = color;
}
