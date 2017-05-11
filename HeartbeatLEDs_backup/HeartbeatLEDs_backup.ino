/*  PulseSensor™ Starter Project   http://www.pulsesensor.com
 *  
This an Arduino project. It's Best Way to Get Started with your PulseSensor™ & Arduino.
-------------------------------------------------------------
1) This shows a live human Heartbeat Pulse.
2) Live visualization in Arduino's Cool "Serial Plotter".
3) Blink an LED on each Heartbeat.
4) This is the direct Pulse Sensor's Signal.  
5) A great first-step in troubleshooting your circuit and connections.
6) "Human-readable" code that is newbie friendly."
*/
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif
#define PIN 9
#define NUM_LEDS 3

 
// Hardware vars
int HeartSensor = 0;        // Pulse Sensor PURPLE WIRE connected to ANALOG PIN 0
//int LED13 = 13;           //  The on-board Arduion LED
Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, PIN, NEO_GRBW + NEO_KHZ800);
int Signal;                 // hold the incoming raw data. Signal value can range 0 - 1024
int Threshold = 550;              // Determine which Signal to count as a beat and which to ignore
 
// Software vars
int count = 0;
int rCount = 0;
int startTime = 0;
int endTime = 0;
int totalBeats = 0;
int resetTimer = 0;
int oldIndex = 0;
int r[] = {127,120,113,106,100,93,86,80,73,66,60,53,46,40,33,26,20,13,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,5,8,11,14,17,20,23,26,29,32,35,38,41,44,47,50,53,56,59,68,78,88,98,108,117,127,137,147,157,166,176,186,196,206,215,225,235,245,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255};
int g[] = {0,5,11,16,22,27,33,38,44,49,55,60,66,71,77,82,88,93,99,105,111,117,123,130,136,142,148,155,161,167,173,180,186,192,198,205,211,217,223,230,230,230,230,230,230,230,230,230,230,230,230,230,230,230,230,230,230,230,230,230,229,228,227,226,226,225,224,223,222,222,221,220,219,218,218,217,216,215,214,214,204,194,184,174,164,154,144,134,124,114,104,94,84,74,64,54,44,34,24,15};
int b[] = {229,229,229,229,229,229,229,229,229,229,229,229,229,229,229,229,229,229,229,230,228,226,225,223,221,220,218,216,215,213,211,210,208,206,205,203,201,200,198,197,187,177,167,157,147,137,128,119,108,98,88,78,68,59,49,39,29,19,9,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5};
double rate;
double recordedTime = 0;
boolean validBeat = false;
boolean madeContact = false;
boolean flop = false;
 
//setup
void setup() {
   //pinMode(LED13,OUTPUT);         // pin that will blink to your heartbeat!
   Serial.begin(9600);         // Set's up Serial Communication at certain speed. 
   strip.begin();
   strip.show(); 
}

/*//TestLOOP
int li = 0;
void loop(){
  if(li == 99){
    li = 0;
  }
  strip.setPixelColor(0, r[li], g[li], b[li]);

  strip.setPixelColor(1, r[li], g[li], b[li]);
  strip.show();
  li++;
  delay(20);
}*/

//Main loop

void loop() {
  Signal = analogRead(HeartSensor);  // Read the PulseSensor's value.
  //Serial.println(Signal);                    // Send the Signal value to Serial Plotter.
  if(rate != 0){
    int index = (int)rate - 60;
    for(int i = 0; i < NUM_LEDS; i++){
      strip.setPixelColor(i, r[index], g[index], b[index]);  
    }
  }

  strip.show();
  /*else{
    for(int i = 0; i < NUM_LEDS; i++){
      strip.setPixelColor(i, 0, 0, 0, 255);
    }
  }
  */
   if(validBeat){
      totalBeats++;
      resetTimer = millis();
      if(!flop){
         startTime = millis();
         flop = true;
      }
      else{
         delay(25);
         endTime = (millis() - startTime);
         if(endTime < 0){
            endTime = 0;
         }
         recordedTime = recordedTime + (endTime *2);
         flop = false;
      }
      //startTime = millis();
      Serial.println("beat");      
      validBeat = false;    
      madeContact = true;     
   }
   
   if(totalBeats == 0 || recordedTime == 0){
      rate = 0;
   }
   else{
      rate = (totalBeats/recordedTime) * 60000;    
   }
   Serial.println(rate);
       
   if(Signal > Threshold){                          // If the signal is above "550"
      //digitalWrite(LED13,HIGH);
      count++;
      rCount = 0;  
   }
   else {
      rCount++;
      if(count >= 12){
         validBeat = true;
      }
      count = 0;
      //digitalWrite(LED13,LOW);                //  Else, the sigal must be below "550", so "turn-off" this LED.
   }
   if(rCount >= 80){
    recordedTime = 0;
    totalBeats = 0;
    flop = false;
    rCount = 0;
   }
// 
//  if(millis() - resetTimer >= 5000 && madeContact){
//    recordedTime = 0;
//    totalBeats = 0;
//    flop = false;
//    madeContact = false;
//    resetTimer = millis();
  //}
 
   delay(10);
}
