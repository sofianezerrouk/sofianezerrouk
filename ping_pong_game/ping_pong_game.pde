// Hello, welcome to my ping pong game made by Sofiane Zerrouk.
// The rules are simple, hit the ball back as many times as you can and try to reach a higher score than my personal best, 20!
// However, every time the ball is hit, it will come back at a faster speed and gradually increase faster and faster.
// Nevertheless, please enjoy my game! :)

float sizeRect = 125;
float diameter = 25;
PVector pos;
PVector speed;
int score;
boolean gameOver;

void setup(){
  size(850,700);
  reset();
}

void reset(){
  score = 0;
  gameOver = false;
  pos = new PVector(width/2, height/4);
  
  // Randomly sets speed of the ball between velocity range of 5-7 (x and y values)
  speed = new PVector(random(-5, 5), random(5, 7));
}

PVector reflect(PVector vec, PVector norm) {
  float dot = norm.dot(vec);
  PVector ndot = new PVector(norm.x * 2 * dot, norm.y * 2 * dot);
  return vec.sub(ndot);
}

void draw(){ 
  
  background(85);
  
  fill(255);
  ellipse(pos.x,pos.y,diameter,diameter);
  
  fill(227,218,218);
  rect(0,0,width,20);
  //rect(width-10,mouseY-sizeRect/2,10,sizeRect);
  rect(mouseX-sizeRect/2,height-10,sizeRect,10);
  
  if (gameOver) {
    textSize(20);
    String msg = "Game Over! Score: " + score;
    float w = textWidth(msg) / 2;
    text(msg, width/2 - w, height/2);
  }
  
  pos = pos.add(speed);
  
  if (pos.y>height-30 && pos.y<height && pos.x>mouseX-sizeRect/2 && pos.x<mouseX+sizeRect/2 ){
    // ball hit paddle
    float dx = pos.x - mouseX;
    PVector n = new PVector(dx * 0.1, -35);
    speed = reflect(speed, n.normalize());
    pos.y = height - 30;
    //speed.x = speed.x * -1;
  } 
  else if (pos.y<25){ // ball hit top of screen
    speed = reflect(speed, new PVector(0, 1));
    pos.y = 25;
    score++;
    
    // increase speed of ball
    float len = speed.mag() * 1.1;
    speed.normalize();
    speed = speed.mult(len);
    
  }
  else if (pos.x>width){
    speed = reflect(speed, new PVector(-1, 0));
  }
  else if (pos.x< 0) {
    speed = reflect(speed, new PVector(1, 0));
  }
  else if (pos.y > height + 10) {
    // game over
    gameOver = true;
  }
}

void mousePressed() {
  reset(); // Everytime the mouse button is pressed, the game will restart

}
