#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor

float maxStrength = 0.5;
float minStrength = 0.125;

float speed = 10.00;

float random (vec2 noise)
{
    //--- Noise: Low Static (X axis) ---
    //return fract(sin(dot(noise.yx,vec2(0.000128,0.233)))*804818480.159265359);
    
    //--- Noise: Low Static (Y axis) ---
    //return fract(sin(dot(noise.xy,vec2(0.000128,0.233)))*804818480.159265359);
    
  	//--- Noise: Low Static Scanlines (X axis) ---
    //return fract(sin(dot(noise.xy,vec2(98.233,0.0001)))*925895933.14159265359);
    
   	//--- Noise: Low Static Scanlines (Y axis) ---
    //return fract(sin(dot(noise.xy,vec2(0.0001,98.233)))*925895933.14159265359);
    
    //--- Noise: High Static Scanlines (X axis) ---
    //return fract(sin(dot(noise.xy,vec2(0.0001,98.233)))*12073103.285);
    
    //--- Noise: High Static Scanlines (Y axis) ---
    //return fract(sin(dot(noise.xy,vec2(98.233,0.0001)))*12073103.285);
    
    //--- Noise: Full Static ---
    return fract(sin(dot(noise.xy,vec2(10.998,98.233)))*12433.14159265359);
}

/*
float random_colour (float noise)
{
    return fract(sin(noise));   
}
*/

void main()
{
    
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 uv2 = fract(fragCoord.xy/iResolution.xy*fract(sin(iTime*speed)));
    
    //--- Strength animate ---
    maxStrength = clamp(sin(iTime/2.0),minStrength,maxStrength);
    //-----------------------
    
    //--- Black and white ---
    vec3 colour = vec3(random(uv2.xy))*maxStrength;
    //-----------------------
        
    /*
    //--- Colour ---
    colour.r *= random_colour(sin(iTime*speed));
    colour.g *= random_colour(cos(iTime*speed));
    colour.b *= random_colour(tan(iTime*speed));
    //--------------
    */
    
    //--- Background ---
    vec3 background = vec3(texture(iChannel0, uv));
    //--------------
    
    fragColor = vec4(background-colour,1.0);
}