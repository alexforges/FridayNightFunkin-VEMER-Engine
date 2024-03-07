#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

int sampleCount = 50;
float blur = 0.125; 
float falloff = 4; 

// use iChannel0 for video, iChannel1 for test grid
#define INPUT bitmap

void main(void)
{

	vec2 p = fragCoord.xy/iResolution.xy;
    
	vec4 col = texture(iChannel0, p);

	if (p.x<.9999)
	{
		vec2 offset = vec2(.0025,.0);
		col.r = texture(iChannel0, p+offset.xy).r;
		col.g = texture(iChannel0, p          ).g;
		col.b = texture(iChannel0, p+offset.yx).b;
	}
	
    fragColor = col;

    vec2 destCoord = openfl_TextureCoordv.xy;

    vec2 direction = normalize(destCoord - 0.5); 
    vec2 velocity = direction * blur * pow(length(destCoord - 0.5), falloff);
	float inverseSampleCount = 1.0 / float(sampleCount); 
    
    mat3x2 increments = mat3x2(velocity * 1.0 * inverseSampleCount,
                               velocity * 2.0 * inverseSampleCount,
                               velocity * 4.0 * inverseSampleCount);

    vec4 accumulator = vec4(0);
    mat3x2 offsets = mat3x2(0); 
    
    for (int i = 0; i < sampleCount; i++) {
        accumulator.r += texture2D(INPUT, destCoord + offsets[0]).r; 
        accumulator.g += texture2D(INPUT, destCoord + offsets[1]).g; 
        accumulator.b += texture2D(INPUT, destCoord + offsets[2]).b; 
        accumulator.a += (texture2D(INPUT, destCoord + offsets[0]).a + texture2D(INPUT, destCoord + offsets[1]).a + texture2D(INPUT, destCoord + offsets[2]).a)/3.0; 
        
        offsets -= increments;
    }

	gl_FragColor = vec4(accumulator / float(sampleCount));
}