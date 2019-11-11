//
// Simple passthrough fragment shader
//

//http://dev.theomader.com/gaussian-kernel-calculator/

varying vec2 v_vTexcoord;

uniform vec2 uBlurPixelInfo;

void main()
{
    vec2 blurOffset [7];
    blurOffset[0] = vec2(-3.0) * uBlurPixelInfo;
    blurOffset[1] = vec2(-2.0) * uBlurPixelInfo;
    blurOffset[2] = vec2(-1.0) * uBlurPixelInfo;
    blurOffset[3] = vec2(0.0);
    blurOffset[4] = vec2(1.0) * uBlurPixelInfo;
    blurOffset[5] = vec2(2.0) * uBlurPixelInfo;
    blurOffset[6] = vec2(3.0) * uBlurPixelInfo;
    
    float blurStrength [9];
    blurStrength[0] = 0.00598;
    blurStrength[1] = 0.060626;
    blurStrength[2] = 0.241843;
    blurStrength[3] = 0.383103;
    blurStrength[4] = 0.241843;
    blurStrength[5] = 0.060626;
    blurStrength[6] = 0.00598;
    
    vec4 col = vec4(0,0,0,0);
    col += texture2D( gm_BaseTexture, v_vTexcoord + blurOffset[0] ) * blurStrength[0];
    col += texture2D( gm_BaseTexture, v_vTexcoord + blurOffset[1] ) * blurStrength[1];
    col += texture2D( gm_BaseTexture, v_vTexcoord + blurOffset[2] ) * blurStrength[2];
    col += texture2D( gm_BaseTexture, v_vTexcoord + blurOffset[3] ) * blurStrength[3];
    col += texture2D( gm_BaseTexture, v_vTexcoord + blurOffset[4] ) * blurStrength[4];
    col += texture2D( gm_BaseTexture, v_vTexcoord + blurOffset[5] ) * blurStrength[5];
    col += texture2D( gm_BaseTexture, v_vTexcoord + blurOffset[6] ) * blurStrength[6];
    
    gl_FragColor = col;
}

