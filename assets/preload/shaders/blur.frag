//original creator: https://www.shadertoy.com/view/XdfGDH

#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor

#ifdef GL_ES
precision mediump float;
#endif

float normpdf(in float x, in float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}

void main()
{
	vec3 c = texture(iChannel0, fragCoord.xy / iResolution.xy).rgb;
		
		//declare stuff
		const int mSize = 11;
		const int kSize = (mSize-1)/2;
		float kernel[mSize];
		vec3 final_colour = vec3(0.0);
		
		//create the 1-D kernel
		float sigma = 12.0;
		float Z = 0.0;
		for (int j = 0; j <= kSize; ++j)
		{
			kernel[kSize+j] = kernel[kSize-j] = normpdf(float(j), sigma);
		}
		
		//get the normalization factor (as the gaussian has been clamped)
		for (int j = 0; j < mSize; ++j)
		{
			Z += kernel[j];
		}
		
		//read out the texels
		for (int i=-kSize; i <= kSize; ++i)
		{
			for (int j=-kSize; j <= kSize; ++j)
			{
				final_colour += kernel[kSize+j]*kernel[kSize+i]*texture(iChannel0, (fragCoord.xy+vec2(float(i),float(j))) / iResolution.xy).rgb;
	
			}
		}
		
		
		fragColor = vec4(final_colour/(Z*Z), 1.0);
}