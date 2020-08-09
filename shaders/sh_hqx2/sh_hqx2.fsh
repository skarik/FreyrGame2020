//
// Simple passthrough fragment shader
//

varying vec4 v_vTexCoords[4];
varying vec4 v_vColour;

uniform vec2 u_spriteSize;
uniform vec4 u_spriteUVs;

uniform sampler2D samplerHQXLut;

const mat3 yuv_matrix = mat3(0.299, 0.587, 0.114, -0.169, -0.331, 0.5, 0.5, -0.419, -0.081);
const vec3 yuv_threshold = vec3(48.0/255.0, 7.0/255.0, 6.0/255.0);
const vec3 yuv_offset = vec3(0, 0.5, 0.5);

#define SCALE 2.0

highp mat3 transpose(in highp mat3 inMatrix)
{
    highp vec3 i0 = inMatrix[0];
    highp vec3 i1 = inMatrix[1];
    highp vec3 i2 = inMatrix[2];

    highp mat3 outMatrix = mat3(
                 vec3(i0.x, i1.x, i2.x),
                 vec3(i0.y, i1.y, i2.y),
                 vec3(i0.z, i1.z, i2.z)
                 );

    return outMatrix;
}

bool delta_diff(vec3 yuv1, vec3 yuv2)
{
	bvec3 res = greaterThan(abs((yuv1 + yuv_offset) - (yuv2 + yuv_offset)), yuv_threshold);
	return res.x || res.y || res.z;
}

void main()
{
	vec2 fp = fract(v_vTexCoords[0].xy / (u_spriteUVs.zw - u_spriteUVs.xy) * u_spriteSize);
	vec2 quad = sign(fp - 0.5);
	mat3 yuv = transpose(yuv_matrix);

	float dx = v_vTexCoords[0].z;
	float dy = v_vTexCoords[0].w;
	vec3 p1  = texture2D(gm_BaseTexture, v_vTexCoords[0].xy).rgb;
	vec3 p2  = texture2D(gm_BaseTexture, v_vTexCoords[0].xy + vec2(dx, dy) * quad).rgb;
	vec3 p3  = texture2D(gm_BaseTexture, v_vTexCoords[0].xy + vec2(dx,  0) * quad).rgb;
	vec3 p4  = texture2D(gm_BaseTexture, v_vTexCoords[0].xy + vec2( 0, dy) * quad).rgb;
	mat4 pixels = mat4(vec4(p1, 0.0), vec4(p2, 0.0), vec4(p3, 0.0), vec4(p4, 0.0));

	vec3 w1  = yuv * texture2D(gm_BaseTexture, v_vTexCoords[1].xw).rgb;
	vec3 w2  = yuv * texture2D(gm_BaseTexture, v_vTexCoords[1].yw).rgb;
	vec3 w3  = yuv * texture2D(gm_BaseTexture, v_vTexCoords[1].zw).rgb;

	vec3 w4  = yuv * texture2D(gm_BaseTexture, v_vTexCoords[2].xw).rgb;
	vec3 w5  = yuv * p1;
	vec3 w6  = yuv * texture2D(gm_BaseTexture, v_vTexCoords[2].zw).rgb;

	vec3 w7  = yuv * texture2D(gm_BaseTexture, v_vTexCoords[3].xw).rgb;
	vec3 w8  = yuv * texture2D(gm_BaseTexture, v_vTexCoords[3].yw).rgb;
	vec3 w9  = yuv * texture2D(gm_BaseTexture, v_vTexCoords[3].zw).rgb;

	bvec3 pattern[3];
	pattern[0] =  bvec3(delta_diff(w5, w1), delta_diff(w5, w2), delta_diff(w5, w3));
	pattern[1] =  bvec3(delta_diff(w5, w4), false       , delta_diff(w5, w6));
	pattern[2] =  bvec3(delta_diff(w5, w7), delta_diff(w5, w8), delta_diff(w5, w9));
	bvec4 cross = bvec4(delta_diff(w4, w2), delta_diff(w2, w6), delta_diff(w8, w4), delta_diff(w6, w8));

	vec2 index;
	index.x = dot(vec3(pattern[0]), vec3(1, 2, 4)) +
			  dot(vec3(pattern[1]), vec3(8, 0, 16)) +
			  dot(vec3(pattern[2]), vec3(32, 64, 128));
	index.y = dot(vec4(cross), vec4(1, 2, 4, 8)) * (SCALE * SCALE) +
	          dot(floor(fp * SCALE), vec2(1, SCALE));

	vec2 l_step = 1.0 / vec2(256.0, 16.0 * (SCALE * SCALE));
	vec2 offset = l_step / 2.0;
	vec4 weights = texture2D(samplerHQXLut, index * l_step + offset);
	float sum = dot(weights, vec4(1));
	vec3 res = (pixels * (weights / sum)).xyz;

	gl_FragColor.rgba = v_vColour * vec4(res, 1.0);
}
