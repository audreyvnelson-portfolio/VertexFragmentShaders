// Fragment shader
// The fragment shader is run once for every /pixel/ (not vertex!)
// It can change the color and transparency of the fragment.

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

// Space for uniform variables ( you can make your own! =D )
// Pass in things from Processing with shader.set("variable_name", value);
// Then declare them here with: uniform float variable_name;


// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertPos;

void main() {  
  float intensity;
  
  // vec4 because RGBA
  vec4 color;
  // simple diffuse lighting
  intensity = max(0.0, dot(vertLightDir, vertNormal));
  
  
  color.rgb = vec3(intensity);
  color.a = 1.0;
  //color.r *= 0.5; // make it kind of cyan by decreasing red,
                  // just as an example. feel free to change
                  // this.
  if(color.r <0.3) color.rgb = vec3(0.1, 0.0, 0.1);
  else if(color.r <0.55) color.rgb = vec3(0.35, 0.25, 0.35);
  else if(color.r < 0.8) color.rgb = vec3(0.6, 0.5, 0.6);
  else if(color.r < 0.95) color.rgb = vec3(0.85, 0.75, 0.85);
  else color.rgb = vec3(1.0, 0.9, 1.0);
  
  // The "return value" of a fragment shader
  gl_FragColor = color * vertColor;
}