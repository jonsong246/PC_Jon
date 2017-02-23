import processing.serial.*; //imports Serial library from Processing

Serial myPort; // creates object from Serial class
int val; // creates variable for data coming from serial port

int total = 0;

Bubble[] bubbles = new Bubble[100];


void setup(){
  size(400,400); 
  background(255);
  smooth();
  
  printArray(Serial.list()); // this line prints the port list to the console
String portName = Serial.list()[1]; //change the number in the [] for the port you need
myPort = new Serial(this, portName, 9600);
  
  for(int i=0; i<bubbles.length; i++){
    bubbles[i] = new Bubble(random(0,400), 420, random(5,40), random(1,5));
  }
}
void mousePressed(){
  if(total != bubbles.length){
    total++;
  }
}

void keyPressed(){
  if(total != 0){
    total--;
  }
}
  

void draw(){
  if ( myPort.available() > 0) { // If data is available,
val = myPort.read(); // read it and store it in val
}
  
  for(int i=0;i<total;i++){
    bubbles[i].display();
    bubbles[i].ascend();
    bubbles[i].perimeters();
    bubbles[i].changeColor();
  }  
  
  println (val); //prints to Processing console
}




  