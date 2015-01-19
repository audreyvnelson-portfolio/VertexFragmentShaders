PShader catShader;
PShader myShader1, myShader2, myShader3, currShader;
PImage catTexture;

float offset = -10, currTime = 0.0;
boolean showStroke = true, keepTime = false, goDown = false;

void setup() {
  size(640, 640, P3D);
  noStroke();
  fill(204);
  
  catTexture = loadImage("data/the_cat.png");
  catShader = loadShader("data/TextFrag.glsl", "data/TextVert.glsl");
  myShader1 = loadShader("data/BasicFrag.glsl", "data/BasicVert.glsl");
  myShader2 = loadShader("data/BasicFrag2.glsl", "data/BasicVert2.glsl");
  myShader3 = loadShader("data/BasicFrag3.glsl", "data/BasicVert3.glsl");
  
  currShader = myShader1;
}

float time = 0.0f;

void draw() {
  time += 0.1;
  
  background(0); 
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  if (mousePressed) 
    offset += (mouseX - pmouseX); /// float(width);
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  translate(width/2, height/2);
  
  // Picture in the background
  // Provided so that you can see "holes"
  // where the sphere is transparent, and have an
  // example of how to use textures with shaders
  shader(catShader);
  noStroke();
  fill(#00FFAA);
  textureMode(NORMAL);
  beginShape();
    texture(catTexture);
    vertex(-300, -300, -200, 0,0);
    vertex( 300, -300, -200, 1,0);
    vertex( 300,  300, -200, 1,1);
    vertex(-300,  300, -200, 0,1);
  endShape();
  
  // Sphere
  //resetShader(); // replace resetShader() with a call to use your own shader
  shader(currShader);
    myShader3.set("time", currTime);
    myShader3.set("yOff", (-1*(320.0 - mouseY))/3.5 );
    myShader3.set("xOff", (-1*(320.0 - mouseX))/3.5);
    //System.out.print(((float)(640 - mouseY)/50) + ", ");
    myShader2.set("squash", ((float)(640 - mouseY)/50));
    myShader1.set("mouseX", (mouseX / -10.0));
    if(goDown){
       currTime-=0.01;
      if(currTime<=0.0) goDown = false; 
    }
    else{
     currTime +=0.01;
      if(currTime >= 1.0) goDown = true; 
    }
  
  fill(#FFFFFF);
  if(showStroke) stroke(#FF0000);
  else noStroke();
  sphereDetail(32);
  sphere(120);
}

void keyPressed(){
  if (key=='s') showStroke = !showStroke;
  if (key=='1') currShader = myShader1;
  if (key=='2') currShader = myShader2;
  if (key=='3'){ currShader = myShader3; keepTime=true;}
}
