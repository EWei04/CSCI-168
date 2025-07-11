                                                                                                                                               
#version 3.7;
// Render settings: Any Frame, no AA
global_settings { assumed_gamma 1.0 }

camera {
  location <0, 10, -125>
  look_at <0, 0, 0>
  angle 30
}

light_source {
  <-275, 150, -90>
  color rgb <1, 1, 1>
}

light_source {
  <100, 25, -90>
  color rgb <1, 1, 1>
}

light_source {
  <-150, -150, -110>
  color rgb <0.4, 0.4, 0.4>
}

light_source {
  <150, -150, -110>
  color rgb <0.3, 0.3, 0.3>
}

light_source {
  <-10, 0, -25>
  color rgb <0.6, 0.6, 0.6>
}

background { color rgb <0.5, 0.5, 0.5> }

// Vase texture
#declare VaseTexture = texture {
  pigment {
    image_map {
        jpeg "vase_texture.jpg"
        map_type 1 // cylindrical
        interpolate 4
    }
    scale <1, 1.5, 1>
  }
  finish {
    specular 0.4
    phong 1
    phong_size 100
  }
}

// Vase geometry
lathe {
  linear_spline
  18,
  <7.75, -15.88>,
  <7.8, -13.95>,
  <8.3, -12.02>,
  <8.97, -10.01>,
  <9.7, -8.01>,
  <10.55, -5.94>,
  <11.45, -3.99>,
  <12.3, -1.9>,
  <13.09, 0.83>,
  <13.36, 3.21>,
  <13.21, 6.01>,
  <12.63, 8.04>,
  <11.73, 9.93>,
  <10.43, 11.46>,
  <9.25, 12.41>,
  <7.91, 13.35>,
  <7, 14.28>,
  <6.53, 15.86>
  texture { VaseTexture }
  rotate <0, 0, 0>
}

// Top torus (rim)
torus {
  7, 0.45
  texture { pigment { color rgb <0, 0, 0> } }
  rotate <0, 0, 0>
  translate <0, 15.8, 0>
}

// Bottom torus
torus {
  8, 0.3
  texture { pigment { color rgb <0, 0, 0> } }
  rotate <0, 0, 0>
  translate <0, -15.7, 0>
}

// Bottom cylinder base
cylinder {
  <0, -16.1, 0>, <0, -15.3, 0>, 8
  texture { pigment { color rgb <0, 0, 0> } }
}
