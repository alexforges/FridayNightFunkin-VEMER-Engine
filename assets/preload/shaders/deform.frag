#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor

void main()
{	
	float stongth = 0.2;
	vec2 uv = fragCoord.xy / iResolution.xy;
	float waveu = sin((uv.y + iTime) * 5.0) * 0.5 * 0.05 * stongth;
	fragColor = texture(iChannel0, uv + vec2(waveu, 0));
}