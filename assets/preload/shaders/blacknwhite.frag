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
    vec2 pos = fragCoord.xy / iResolution.xy;
    vec4 texColor = texture(iChannel0, pos);
    
    float avg = (texColor.r + texColor.g + texColor.b) / 3.0;
    float rd = avg - texColor.r;
    float gd = avg - texColor.g;
    float bd = avg - texColor.b;
    float dt = (cos(iTime) + 1.0) / 2.0;
    
    texColor.r = texColor.r + dt * rd;
    texColor.g = texColor.g + dt * gd;
    texColor.b = texColor.b + dt * bd;
    
    fragColor = texColor;
}