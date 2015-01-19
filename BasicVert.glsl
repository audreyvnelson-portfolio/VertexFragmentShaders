// Vertex shader
// The vertex shader is run once for every /vertex/ (not pixel)!
// It can change the (x,y,z) of the vertex, as well as its normal for lighting.

// Set automatically by Processing
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;

// Space for uniform variables ( you can make your own! =D )
// Pass in things from Processing with shader.set("variable_name", value);
// Then declare them here with: uniform float variable_name;
//float position = -100.0;
//float change = 10.0;
uniform float mouseX;

// Come from the geometry/material of the object
attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

// These values will be sent to the fragment shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertPos;

void main() {
  vertColor = color;
  
  vertNormal = normalize(normalMatrix * normal);
  
  
  
  // We have to create a copy of vertex because modifying
  // attribute variables is against the rules
  vec4 vert = vertex; 
  
//while(position < 100.0){
  //if(vertex.x > position && vertex.x < position+20.0) vert.y += change; 
  //position +=20.0;
  //change = 0.0 - change;
  //}
  
  vert.y += 20.0*sin(5.0 * 3.1471 * (vert.x + mouseX) / 180.0);
  
  // think of gl_Position as a return value for vertex shaders
  gl_Position = transform * vert; 
  vertLightDir = -lightNormal;
  vertPos = vert;
}