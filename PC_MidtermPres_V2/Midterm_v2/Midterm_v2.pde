import processing.sound.*; // sound library
import processing.serial.*; // imports Serial library from Processing

import ddf.minim.*;
Minim minim;
AudioPlayer player;
AudioPlayer player2;
AudioInput input;



Serial myPort; // creates object from Serial class
SoundFile file;
int val; // creates variable for data coming from serial port

color backgroundColor[];
ArrayList<Shape> shapeList = new ArrayList<Shape>();
int currentColor;
int r;
int g;
int b;
int currentTime = 3;
float nextScreenTimer;
float updateTimer;
float resetTimer;
boolean keyR = false;
boolean buttonLock = false;
boolean dontDisplay = false;

 
void setup(){
  size(displayWidth, displayHeight);
  //fullScreen();
  smooth();
  
  minim = new Minim(this);
  
  //file = new SoundFile(this, "PopV1.mp3");
 
  nextScreenTimer = millis();
  updateTimer = millis();
  resetTimer = millis();
 
  printArray(Serial.list()); // this line prints the port list to the console

  String portName = Serial.list()[1]; //change the number in the [] for the port 
  myPort = new Serial(this, portName, 9600);
  //shape1 = new Shape();
  shapeList.add(new Shape());
  
  createNewBackground();
  }

 
void draw() {  
  if (myPort.available() > 0) { // If data is available,
    val = myPort.read(); // read it and store it in val
  }

  background(backgroundColor[currentColor]);
  
  Shape latestShape = shapeList.get(shapeList.size() - 1);
  try{
    color testColor = backgroundColor[49];
    if(testColor != color(0,0,0)){
      dontDisplay = false;
    }
  }
  catch(NullPointerException e){
    dontDisplay = true;
  }
  if(!dontDisplay){
    
    latestShape.updateColor(val);

  }
  
  //println(val); // Prints to Processing console
  for(int i = 0; i < shapeList.size(); i++){
    Shape currentShape = shapeList.get(i);
        
    currentShape.display(i);

    if (latestShape.checkColorMatch()) {
    textSize(24);
    fill(0);
    text((currentTime), (latestShape.x - 5), (latestShape.y + 5));
      if (millis() - updateTimer >= 1000) {           
        if(currentTime == 1) {
          currentTime = 2;
        }
        else{
          currentTime--;
        }
        updateTimer = millis();
      }
          
      if (millis() - nextScreenTimer >= 2000) {
        nextScreenTimer = millis();
        println("next screen trigger");
        player = minim.loadFile("PopV1.mp3");
        player2 = minim.loadFile("PopV1.mp3");
        if(latestShape.shapeType == 2){
          player.play();
          boolean wait = false;
          int timer = millis();
          //start 
          do{
            if(millis() - timer >= 85){
              player2.play();
              wait = true;
            }
            
          } while(wait == false);
          //end of loop
        }
        else{         

          player.play();
        }
        createNewBackground();
        shapeList.add(new Shape());
      }
    }
    else{
      currentTime = 2;
      nextScreenTimer = millis();
      updateTimer = millis();
    }    
    }
  }
 
void mousePressed() {
  if (currentColor < 49) {
    currentColor++;
  }
}

void keyPressed() {
  if (key == 'r') {
    keyR = true;
  }
}
 
void createNewBackground(){
  //Start of choosing background color
  currentColor = int(random(4,45));
  
  boolean rStart = true; //true = 255; false = 0;
  boolean gStart = true; //true = 255; false = 0;
  boolean bStart = true; //true = 255; false = 0;
  
  for(int i = 0; i < 3; i++){
    float rand = random(0,1);
  
    if(i == 0){      
      if(rand < .5){
        r = int(random(40,51));
        rStart = false;
      }
      else{
        r = int(random(245,256));
      }
    }
    else if(i == 1){     
      if(rand < .5){
        g = int(random(40,51));
        gStart = false;
      }
      else{
        g = int(random(245,256));
      }
    }       
    else if(i == 2){
      if(rand < .5){
        b = int(random(40,51));
        bStart = false;
      }
      else{
        b = int(random(245,256));
      }
    }
  }
    
  if(r == 50 && g == 50 && b == 50){
    int tempRandom = int(random(0,3));
    if(tempRandom == 0){
      r = 255;
    }
    else if(tempRandom == 1){
      g = 255;
    }
    else if(tempRandom == 2){
      b = 255;
    }
  }
 //End of choosing background color
  
  //start of creating background array
  backgroundColor = new color[50];
 
  for (int i = 0; i < backgroundColor.length; i++) { 
    if (i < 16) {
      if(rStart){
        r = r - int(random(10,16));
      }
      else{
        r = r + int(random(10,13));
      }
    }
    else if (i >= 16 && i < 32) {
      if(gStart){
        g = g - int(random(10,16));
      }
      else{
        g = g + int(random(10,13));
      }
    }
    
    else if (i >=32 && i < 50) {
      if(bStart){
        b = b - int(random(10,15));
      }
      else{
        b = b + int(random(10,12));
      }
    }
   
    backgroundColor[i] = color(r, g, b);
  }
  //end of creating background array
}


  