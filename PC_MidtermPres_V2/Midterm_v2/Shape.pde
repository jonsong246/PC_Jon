class Shape {
  color shapeColor;
  int shapeType;
  float triangleSwap;
  int s_r;
  int s_g;
  int s_b;
  int shapeIndex;
  int x;
  int y;
  int difficultyMult;
  
  Shape(){
    shapeType = int(random(0,3));
    triangleSwap = random(0,1);
    if(shapeType == 2){
      if(triangleSwap < .5){        
        int circleOrSquare = int(random(0,2));
        if(circleOrSquare == 0){
          shapeType = 0;
        }
        else{
          shapeType = 1;
        }
      }  
    }
  
    rectMode(CENTER);
    
    difficultyMult = 8;
    if (shapeType == 2){
      difficultyMult = 3;
    }
    
    x = int(random(100, width - 100));
    y = int(random(100, height - 100));
  }
  
  void updateColor(int _val){
    for(int i = 0; i < 200; i = i + 4){
      if(i > _val && i <= _val + 4){
        shapeColor = backgroundColor[i/4]; // i think
        shapeIndex = i/4;
      }
    }
  }
  
  void display(int i){
    if(i == shapeList.size() - 1){
      strokeWeight(5);
      stroke(255,255,255);
    }
    else{      
      strokeWeight(3);
      stroke(0);
    }
    
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
    if(shapeIndex < (currentColor + difficultyMult) && shapeIndex > (currentColor - difficultyMult)){
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