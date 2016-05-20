precision highp float;

#define saturate(i) clamp(i,0.,1.)
#define PI 3.14159265

uniform vec2 resolution;
uniform sampler2D layer0;
uniform sampler2D texture;

uniform float proc;

void main() {
  vec2 uv = gl_FragCoord.xy / resolution;
  vec4 tex = texture2D( layer0, uv );

  gl_FragColor = vec4( mix(
    texture2D( texture, uv ).xyz,
    tex.xyz,
    tex.w
  ), 1.0 );
}
