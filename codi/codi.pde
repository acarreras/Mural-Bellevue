//int colors[] = {#474747, #363636, #A8A7A7, #CC527A, #E8175D};
//int colors[] = {#BD5532, #373B44, #73C8A9, #DEE1B6, #E1B866};
//int colors[] = {#CDB380, #036564, #033649, #031634, #E8DDCB};
//int colors[] = {#2A2C31, #3E4147, #FFFEDF, #DFBA69, #5A2E2E};
//int colors[] = {#2B4E72, #4E4D4A, #353432, #94BA65, #2790B0};
//int colors[] = {#2A363B, #99B898, #FECEA8, #FF847C, #E84A5F};
//int colors[] = {#E8D5B7, #0E2430, #FC3A51, #F5B349, #E8D5B9};
int colors[] = {#9F111B, #E33546, #292C37, #CCCCCC, #000000};
//int colors[] = {#696758, #45484B, #36393B, #EEE6AB, #C5BC8E};

color c1 = colors[0];
color c2 = colors[1];
color c3 = colors[2];
color c4 = colors[3];
color c5 = colors[4];

int numcc = 1;

int midaw = 15;
int midah = 15;
float gruix = 1;
float posX, posY;
float angle = random(40,45);
int signeangle = 1;

// pareto distribution
float alfa = 2;
float xm = random(0.2,2);
float x = xm;
float salt = 0.12;
float num, denom, fx;
float fx0;

boolean brects = true;

void setup() {
  size(1578,548); // 789.94 x 274.32 cm = 9' x 25'11"
  desplacaColorsEndavant();
  desplacaColorsEndavant();
  background(colors[0]);
}

void draw() {
  while(fx > 0.01){
    //println("dins while at " + frameCount + "fx " + fx);
    pushMatrix();
    translate(posX,posY);
    float num = (alfa*pow(xm,alfa));
    float denom = pow(x,alfa+1);
    fx = num/denom;
    //println("fx: " + fx);
    x = x + salt;
    
    pushMatrix();
    translate(0,midah*fx);
    rotate(radians(angle));
    gruix = map(fx, 2,0, 4,1);
    //fill(colors[numcc],150);
    //noStroke();
    //line4(0,0, midaw,0, gruix);
    //stroke(lerpColor(colors[numcc],colors[(numcc+1)%5],map(fx,0,fx0,0.,1.)),150);
    stroke(colors[numcc], 220);
    line(0,0, midaw,0);
    popMatrix();
    
    popMatrix();
  }
  if(brects) nouRect(random(0,width-midaw), random(0,height-midah)); 
}

void mousePressed(){
  if(mouseButton == LEFT){
    nouRect(mouseX,mouseY);
  }
  if(mouseButton == RIGHT){
    fill(colors[numcc],150);
    nouCercle(mouseX,mouseY);
  }
}

void keyPressed() {
  if (key == 'p') noLoop();
  else if (key == 'l') loop();
  else if (key == '+') desplacaColorsEndavant();
  else if (key == '-') desplacaColorsEnrera();
  else if (key == ' ') {
    pantallazo();
  }
  else if(key == 'b'){
    background(colors[0]);
  }
  else if(key == '0'){
    // efectePaperSVG(80);
    brects = !brects;
  }
  else if(key == 'n'){
    numcc++;
    if(numcc > 4) numcc = 0;
  }
}

void desplacaColorsEndavant(){
  color cc = c1;
  c1 = c2;
  c2 = c3;
  c3 = c4;
  c4 = c5;
  c5 = cc; 
  colors[0] = c1;
  colors[1] = c2;
  colors[2] = c3;
  colors[3] = c4;
  colors[4] = c5;
}

void desplacaColorsEnrera(){
  color cc = c5;
  c5 = c4;
  c4 = c3;
  c3 = c2;
  c2 = c1;
  c1 = cc;
  colors[0] = c1;
  colors[1] = c2;
  colors[2] = c3;
  colors[3] = c4;
  colors[4] = c5;
}

void pantallazo(){
  String d = year() + "_" + nf(month(),2) + "_"  + nf(day(),2) + "_";
  d = d + nf(hour(),2) + "_"  + nf(minute(),2) + "_"  + nf(second(),2);
  
  String filename = "./../captures/mural" + d + ".png";
  println("  --- pantallazo capturat");
  save(filename);
}
void nouRect(float px, float py){
  //println("nouRect");
  midaw = (int)random(20,30);
  midah = (int)random(70,140);
  posX = px;
  posY = py;
  
  xm = random(0.2,2);
  x = xm;
  salt = random(0.06, 0.12);
  
  if(random(1) > 0.82) signeangle = -1;
  else signeangle = 1;
  angle = signeangle*random(40,45);
  
  //numcc++;
  if(numcc > 4) numcc = 0;
  
  fx = 9999;
  float num = (alfa*pow(xm,alfa));
  float denom = pow(x,alfa+1);
  fx0 = num/denom;
}

void nouCercle(float px, float py){
  /*pushMatrix();
  translate(px,py);
  rotate(radians(random(40,45)));
  line4(0,0, midaw,0, 4);
  cercle4(lerp(0,midaw,0.5),0, 4, 6);
  popMatrix();
  */
  pushMatrix();
  translate(px,py);
  rotate(radians(random(40,45)));
  stroke(colors[numcc],150);
  line(-midaw*0.5,0, midaw*0.5,0);
  fill(c1);
  stroke(colors[numcc],150);
  circle(0,0,2*4);
  popMatrix();
}

void line4(float x1, float y1, float x2, float y2, float weight){
  for (int i=0; i<weight*100; i++) {
    float theta = random(TWO_PI);
    float nx1 = x1 + random(weight / 2) * cos(theta);
    float ny1 = y1 + random(weight / 2) * sin(theta);
    float nx2 = x2 + random(weight / 2) * cos(theta);
    float ny2 = y2 + random(weight / 2) * sin(theta);
    float lval = random(1);
    ellipse(lerp(nx1, nx2, lval), lerp(ny1, ny2, lval), 0.5, 0.5);
  }
}

void cercle4(float x, float y, float r, float weight){
  noStroke();
  fill(c1);
  circle(x,y,2*r);
  fill(colors[numcc],150);
  for (int i=0; i<weight*40; i++) {
    float theta = random(TWO_PI);
    float nx1 = x + (r + random(weight/2)) * cos(theta);
    float ny1 = y + (r + random(weight/2)) * sin(theta);
    float nx2 = x + (r + random(weight/2)) * cos(theta);
    float ny2 = y + (r + random(weight/2)) * sin(theta);
    float lval = random(1);
    ellipse(lerp(nx1, nx2, lval), lerp(ny1, ny2, lval), 0.5, 0.5);
  }
}
