class Shape {
  color shapeColor;
  int shapeType;
  int s_r;
  int s_g;
  int s_b;
  int shapeIndex;
  int x;
  int y;
  
  Shape(){
    shapeType = int(random(0,3));
    rectMode(CENTER);
    
    
    x = int(random(100,1100));
    y = int(random(100, 700));

  }
  
  void updateColor(int _val){
    for(int i = 0; i < 200; i = i + 4){
      if(i > _val && i <= _val + 4){
        shapeColor = backgroundColor[i/4]; // i think
        shapeIndex = i/4;
      }
    }
  }
  
  void display(){
    strokeWeight(2);
    fill(shapeColor);
    if(shapeType == 0){
      rect(x, y, 100, 100);
    }
    else if(shapeType == 1){
      ellipse(x, y, 100, 100);
    }
    else if(shapeType == 2){
      triangle(x, y - 60, x - 48, y + 36, x + 52, y + 36);
    }
    
    
  }
  
  boolean checkColorMatch(){
    if(shapeIndex < (currentColor + 4) && shapeIndex > (currentColor -4)){
      return true;
    }
    else{
      return false;
    }
  }
}

//Reset Text
//Automated control for background color on function pass
//Timer for middle square color with background color corresponding 
//Range function for color values to be accepted within a certain range 
//Adding geometric shape and x,y locations for function pass record