float deltaTime;
PVector bgColor;
PVector fillColor;
PVector fill2Color;
PVector fill3Color;
int frames;

float proc;
float procV;

float rot;
float rotV;

int phase;
int phasePrev;

PShader shaderReturn;
PShader shaderSlash;

PGraphics[] layers;

void setup() {
  size( 800, 800, P2D );
  deltaTime = 1.0 / 2000.0;
  frames = 2000;

  bgColor = new PVector( 0.0, 0.0, 0.0 );
  fillColor = new PVector( 0.0, 0.0, 0.0 );
  fill2Color = new PVector( 0.0, 0.0, 0.0 );
  fill3Color = new PVector( 0.0, 0.0, 0.0 );

  layers = new PGraphics[ 3 ];
  for ( int iLayer = 0; iLayer < 3; iLayer ++ ) {
    layers[ iLayer ] = createGraphics( width, height );
  }

  shaderReturn = loadShader( "return.frag" );
  shaderReturn.set( "resolution", width * 1.0, height * 1.0 );

  shaderSlash = loadShader( "slash.frag" );
  shaderSlash.set( "resolution", width * 1.0, height * 1.0 );
}

color vecToColor( PVector _vec ) {
  return color(
    _vec.x * 256.0, 
    _vec.y * 256.0, 
    _vec.z * 256.0
  );
}

color vecToColor( PVector _vec, float _alpha ) {
  return color(
    _vec.x * 256.0, 
    _vec.y * 256.0, 
    _vec.z * 256.0,
    _alpha * 256.0
  );
}

void draw() {
  phasePrev = phase;
  int phaseRaw = int( frameCount * 4.0 / frames );
  phase = phaseRaw % 4;
  if ( phase != phasePrev ) {
    proc = 0.0;
    procV = 0.0;
  }

  float k = 1400.0;
  float zeta = 1.0;
  float procT = 1.0;
  procV += ( -k * ( proc - procT ) - 2.0 * procV * sqrt( k ) * zeta ) * deltaTime;
  proc += procV * deltaTime;
  
  k = 1800.0;
  zeta = 0.5;
  float rotT = phaseRaw * PI / 2.0 - 0.1;
  rotV += ( -k * ( rot - rotT ) - 2.0 * rotV * sqrt( k ) * zeta ) * deltaTime;
  rot += rotV * deltaTime;

  if ( phase == 0 ) {
    fillColor = new PVector( 0.78, 0.6, 0.5 ).lerp( fillColor, exp( -deltaTime * 20.0 ) );
    fill2Color = new PVector( 0.78, 0.6, 0.5 ).lerp( fill2Color, exp( -deltaTime * 20.0 ) );
    bgColor = new PVector( 0.58, 0.4, 0.3 ).lerp( bgColor, exp( -deltaTime * 20.0 ) );

    layers[ 0 ].beginDraw();
    layers[ 0 ].clear();
    layers[ 0 ].background( vecToColor( bgColor ) );
    
    layers[ 0 ].translate( width / 2.0, height / 2.0 );
    layers[ 0 ].scale( width / 50.0 );
    layers[ 0 ].rotate( rot );

    layers[ 0 ].fill( vecToColor( fillColor ) );
    layers[ 0 ].noStroke();
    for ( int iy = -10; iy < 11; iy ++ ) {
      for ( int ix = -5; ix < 6; ix ++ ) {
        layers[ 0 ].pushMatrix();
        layers[ 0 ].translate( ix * 8.0, iy * 8.0 );
        layers[ 0 ].ellipse( 0, -proc * 4.0, 2, 2 );
        layers[ 0 ].ellipse( 0, proc * 4.0, 2, 2 );
        layers[ 0 ].rect( -1.0, -proc * 4.0, 2.0, proc * 8.0 );
        layers[ 0 ].translate( 4.0, 4.0 );
        layers[ 0 ].ellipse( 0, -proc * 4.0, 2, 2 );
        layers[ 0 ].ellipse( 0, proc * 4.0, 2, 2 );
        layers[ 0 ].rect( -1.0, -proc * 4.0, 2.0, proc * 8.0 );
        layers[ 0 ].popMatrix();
      }
    }

    layers[ 0 ].endDraw();

    shaderReturn.set( "layer0", layers[ 0 ] );
    filter( shaderReturn );
  } else if ( phase == 1 ) {
    fillColor = new PVector( 0.95, 0.72, 0.65 ).lerp( fillColor, exp( -deltaTime * 20.0 ) );
    fill2Color = new PVector( 0.97, 0.96, 0.9 ).lerp( fill2Color, exp( -deltaTime * 20.0 ) );
    fill3Color = new PVector( 0.97, 0.96, 0.9 ).lerp( fill3Color, exp( -deltaTime * 20.0 ) );
    bgColor = new PVector( 0.94, 0.65, 0.5 ).lerp( bgColor, exp( -deltaTime * 20.0 ) );

    layers[ 0 ].beginDraw();
    layers[ 0 ].clear();
    layers[ 0 ].background( vecToColor( bgColor ) );
    
    layers[ 0 ].translate( width / 2.0, height / 2.0 );
    layers[ 0 ].scale( width / 50.0 );
    layers[ 0 ].rotate( rot );

    layers[ 0 ].fill( vecToColor( fillColor ) );
    layers[ 0 ].noStroke();
    for ( int i = -10; i < 11; i ++ ) {
      layers[ 0 ].pushMatrix();
      layers[ 0 ].translate( i * 4.0, 0.0 );
      layers[ 0 ].rect( -1.0, -30.0, 2.0, 60.0 );
      layers[ 0 ].popMatrix();
    }

    layers[ 0 ].endDraw();

    layers[ 1 ].beginDraw();
    layers[ 1 ].clear();
    layers[ 1 ].background( vecToColor( bgColor ) );
    
    layers[ 1 ].translate( width / 2.0, height / 2.0 );
    layers[ 1 ].scale( width / 50.0 );
    layers[ 1 ].rotate( rot );

    layers[ 1 ].fill( vecToColor( fillColor ) );
    layers[ 1 ].noStroke();
    for ( int i = -10; i < 11; i ++ ) {
      layers[ 1 ].pushMatrix();
      layers[ 1 ].translate( i * 4.0, 0.0 );
      layers[ 1 ].rect( -1.0, -30.0, 2.0, 60.0 );
      layers[ 1 ].popMatrix();
      
      layers[ 1 ].pushMatrix();
      layers[ 1 ].translate( 0.0, i * 4.0 );
      layers[ 1 ].rect( -30.0, -1.0, 60.0, 2.0 );
      layers[ 1 ].popMatrix();
    }

    layers[ 1 ].fill( vecToColor( fill2Color ) );
    for ( int i = -10; i < 11; i ++ ) {
      for ( int j = -10; j < 11; j ++ ) {
        layers[ 1 ].pushMatrix();
        layers[ 1 ].translate( j * 4.0, i * 4.0 );
        layers[ 1 ].rect( -1.0, -1.0, 2.0, 2.0 );
        layers[ 1 ].popMatrix();
      }
    }

    layers[ 1 ].endDraw();

    shaderSlash.set( "proc", proc );
    shaderSlash.set( "rot", rot );
    shaderSlash.set( "layer0", layers[ 0 ] );
    shaderSlash.set( "layer1", layers[ 1 ] );
    filter( shaderSlash );
  } else if ( phase == 2 ) {
    fillColor = new PVector( 0.5, 0.1, 0.2 ).lerp( fillColor, exp( -deltaTime * 20.0 ) );
    fill2Color = new PVector( 0.1, 0.1, 0.1 ).lerp( fill2Color, exp( -deltaTime * 20.0 ) );
    fill3Color = new PVector( 1.0, 1.0, 1.0 ).lerp( fill3Color, exp( -deltaTime * 20.0 ) );
    bgColor = new PVector( 0.1, 0.1, 0.1 ).lerp( bgColor, exp( -deltaTime * 20.0 ) );

    layers[ 0 ].beginDraw();
    layers[ 0 ].clear();
    layers[ 0 ].background( vecToColor( bgColor ) );
    
    layers[ 0 ].translate( width / 2.0, height / 2.0 );
    layers[ 0 ].scale( width / 50.0 );
    layers[ 0 ].rotate( rot );

    layers[ 0 ].fill( vecToColor( fillColor ) );
    for ( int i = -10; i < 11; i ++ ) {
      layers[ 0 ].pushMatrix();
      layers[ 0 ].translate( i * 4.0, 0.0 );
      layers[ 0 ].rect( -1.0 - proc, -30.0, 2.0 + 2.0 * proc, 60.0 );
      layers[ 0 ].popMatrix();

      layers[ 0 ].pushMatrix();
      layers[ 0 ].translate( 0.0, i * 4.0 );
      layers[ 0 ].rect( -30.0, -1.0 - proc, 60.0, 2.0 + 2.0 * proc );
      layers[ 0 ].popMatrix();
    }

    for ( int iy = -10; iy < 11; iy ++ ) {
      for ( int ix = -10; ix < 11; ix ++ ) {
        layers[ 0 ].fill( vecToColor( ( ix + iy + 20 ) % 2 == 0 ? fill3Color : fill2Color ) );

        layers[ 0 ].pushMatrix();
        layers[ 0 ].translate( ix * 4.0, iy * 4.0 );
        layers[ 0 ].rect( -1.0 - proc, -1.0 - proc, 2.0 + 2.0 * proc, 2.0 + 2.0 * proc );
        layers[ 0 ].popMatrix();
      }
    }

    layers[ 0 ].endDraw();

    shaderReturn.set( "layer0", layers[ 0 ] );
    filter( shaderReturn );
  } else {
    fillColor = new PVector( 1.0, 1.0, 1.0 ).lerp( fillColor, exp( -deltaTime * 20.0 ) );
    fill2Color = new PVector( 0.1, 0.1, 0.1 ).lerp( fill2Color, exp( -deltaTime * 20.0 ) );
    fill3Color = new PVector( 1.0, 1.0, 1.0 ).lerp( fill3Color, exp( -deltaTime * 20.0 ) );
    bgColor = new PVector( 0.07, 0.16, 0.34 ).lerp( bgColor, exp( -deltaTime * 20.0 ) );
    
    layers[ 0 ].beginDraw();
    layers[ 0 ].clear();
    layers[ 0 ].background( vecToColor( bgColor ) );
    
    layers[ 0 ].translate( width / 2.0, height / 2.0 );
    layers[ 0 ].scale( width / 50.0 );
    layers[ 0 ].rotate( rot );
    
    layers[ 0 ].fill( vecToColor( fill3Color ) );
    for ( int iy = -10; iy < 11; iy ++ ) {
      for ( int ix = -10; ix < 11; ix ++ ) {
        if ( ( ( ix + iy + 20 ) % 2 ) == 1 ) { continue; }
        layers[ 0 ].pushMatrix();
        layers[ 0 ].translate( ix * 4.0, iy * 4.0 );
        
        layers[ 0 ].beginShape();
        for ( int ip = 0; ip < 64; ip ++ ) {
          float ax = cos( ( ip / 32.0 - 0.25 ) * PI );
          float ay = -sin( ( ip / 32.0 - 0.25 ) * PI );
          float bx = constrain( ip < 32 ? ( 6.0 - ip / 4.0 ) : ( ip / 4.0 - 14.0 ), -2.0, 2.0 );
          float by = constrain( ip < 32 ? ( 2.0 - ip / 4.0 ) : ( ip / 4.0 - 10.0 ), -2.0, 2.0 );
          layers[ 0 ].vertex(
            lerp( bx, ax, proc ),
            lerp( by, ay, proc )
          );
        }
        layers[ 0 ].endShape();
        
        layers[ 0 ].popMatrix();
      }
    }
    
    layers[ 0 ].endDraw();

    shaderReturn.set( "layer0", layers[ 0 ] );
    filter( shaderReturn );
  }
  
  //if ( frames / 4 <= frameCount ) {
  //  saveFrame( "out/#####.png" );
  //}
  //if ( frames * 5 / 4 == frameCount ) {
  //  exit();
  //}
}