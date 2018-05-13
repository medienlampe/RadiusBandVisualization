float currentAngle;

void setup(){
  frameRate(60);

  fullScreen(P3D);
  background(0);
  smooth();

  prepareBandLib(2);
  colorMode(HSB, specSize, 100, 100);
}

void draw(){
  stroke(0);
  fill(0, 16);
  rect(0, 0, width, height);

  // prepare data
  bandLibLogic();

  currentAngle = 360.0f / maxSteps;

  for(int i = 0; i < maxSteps; i++) {
    float shortRadius = 0;
    float longRadius = 200 + (height/127 * currentData[i]);

    // calculate the coordinates to draw the lines
    float x1 = cos(radians(currentAngle * i)) * shortRadius;
    float y1 = sin(radians(currentAngle * i)) * shortRadius;
    float x2 = cos(radians(currentAngle * i)) * longRadius;
    float y2 = sin(radians(currentAngle * i)) * longRadius;

    stroke(i * bandWidth, 100, 100);
    line(x1 + width/2, y1 + height/2, x2 + width/2, y2 + height/2);
  } 
}