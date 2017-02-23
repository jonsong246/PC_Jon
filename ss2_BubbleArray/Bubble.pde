 class Bubble{
  
float x,y;
float speedX = 0;
float speedY = 0;
float radius;
int R,G,B;

//Constructor:
Bubble(float _x, float _y, float _radius, float _speedY){

  x = _x;
  y = _y;
  radius = _radius;
  speedY = _speedY;
}

//Functionality

void changeColor(){
  fill(random(0,255),random(0,255),random(0,255), 40);
}

void display(){
  ellipse(x,y,val,val);
}
  
void ascend(){
  y = y - speedY;
}

void perimeters(){
  if(y<-20){
    y = 420;
  }
}
}