precision highp float;

#define saturate(i) clamp(i,0.,1.)
#define PI 3.14159265

uniform vec2 resolution;
uniform sampler2D layer0;
uniform sampler2D layer1;
uniform sampler2D texture;

uniform float proc;
uniform float rot;

mat2 rotate2D( float _t ) {
  return mat2( cos( _t ), sin( _t ), -sin( _t ), cos( _t ) );
}

void main() {
  vec2 uv = gl_FragCoord.xy / resolution;
  vec4 tex0 = texture2D( layer0, uv );
  vec4 tex1 = texture2D( layer1, uv );

  vec2 phaseUv = rotate2D( -rot ) * ( uv - 0.5 );
  float phase = ( phaseUv.x + phaseUv.y ) * 8.0 * PI;
  float slash = saturate( ( mod( phase, 1.0 ) + proc * 1.2 - 1.1 ) * 10.0 );

  gl_FragColor = vec4( mix(
    tex0.xyz,
    tex1.xyz,
    tex1.w * slash
  ), 1.0 );
}
