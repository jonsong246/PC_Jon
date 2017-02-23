//https://learn.sparkfun.com/tutorials/sik-experiment-guide-for-arduino---v32/experiment-4-driving-multiple-leds
// To keep track of all the LED pins, we'll use an "array".
// An array lets you store a group of variables, and refer to them
// by their position, or "index". Here we're creating an array of
// eight integers, and initializing them to a set of values:

float pressLength_milliSeconds = 0;

int optionOne_milliSeconds = 100;
int optionTwo_milliSeconds = 2000;

int buttonPin = 13;

int ledPins[] = {2,3,4,5,6,7};
int ledPin_Option_3 = 13;

// The first element of an array is index 0.
// We've put the value "2" in index 0, "3" in index 1, etc.
// The final index in the above array is 7, which contains
// the value "9".

// We're using the values in this array to specify the pin numbers
// that the eight LEDs are connected to. LED 0 is connected to 
// pin 2, LED 1 is connected to pin 3, etc.

void setup(){
  int index;

  //Initialize the pushbutton pin as an input pullup
  pinMode(buttonPin, INPUT_PULLUP);

  

 // In this sketch, we'll use "for() loops" to step variables from
  // one value to another, and perform a set of instructions for 
  // each step. For() loops are a very handy way to get numbers to
  // count up or down.

  // Every for() loop has three statements separated by
  // semicolons (;):

  //   1. Something to do before starting
  //   2. A test to perform; as long as it's true, keep looping
  //   3. Something to do after each loop (increase a variable)

  // For the for() loop below, these are the three statements:

  //   1. index = 0;    Before starting, make index = 0.
  //   2. index <= 7;   If index is less or equal to 7,
  //                    run the following code.
  //            (When index = 8, continue with the sketch.)
  //   3. index++   Putting "++" after a variable means
  //                    "add one to it".
  //            (You can also use "index = index + 1".)

  // Every time you go through the loop, the statements following
  // the for() (within the brackets) will run.

  // When the test in statement 2 is finally false, the sketch
  // will continue.


  // Here we'll use a for() loop to initialize all the LED pins
  // to outputs. This is much easier than writing eight separate
  // statements to do the same thing.

  // This for() loop will make index = 0, then run the pinMode()
  // statement within the brackets. It will then do the same thing
  // for index = 2, index = 3, etc. all the way to index = 7.

for(index = 0; index <= 5; index++){
  pinMode(ledPins[index], OUTPUT);
  //led Pins[index is replaced by the value in the array.
  //For example, ledPins[0] is 2

  //Start serial communciation
  Serial.begin(9600);
}
}

void loop(){
  //Record the tenths of seconds the button is being held down
  while(digitalRead(buttonPin) == LOW){
    
    delay(100);
    pressLength_milliSeconds = pressLength_milliSeconds + 100;

    //display how long button has been held
    Serial.print("ms = ");
    Serial.println(pressLength_milliSeconds);
  }

  //Option 2 - Execute the second option if the button is held long enough
  if(pressLength_milliSeconds >= optionTwo_milliSeconds){
  randomLED();
}

//Option 1 = Execute the first option
else if(pressLength_milliSeconds >= optionOne_milliSeconds){
  marquee();
  }

  //reset the pressLength_milliSeconds after loop is done 
  pressLength_milliSeconds = 0;

}

void randomLED(){
  int index;
  int delayTime;

  // The random() function will return a semi-random number each
  // time it is called. See http://arduino.cc/en/Reference/Random
  // for tips on how to make random() even more random.

  index = random(6);    // pick a random number between 0 and 7
  delayTime = 100;

  digitalWrite(ledPins[index], HIGH);  // turn LED on
  delay(delayTime);                    // pause to slow down
  digitalWrite(ledPins[index], LOW);   // turn LED off
}

void marquee(){
  int index;
  int delayTime = 200; //milliseconds to pause between LEDs
                       //Make this smaller for faster switching

   //Step through the first 3 LEDs
   //(We'll light up on in the lower 3 and one in the upper 3)

   for(index = 0; index <= 2; index++){ // Step from 0 to 2
    digitalWrite(ledPins[index], HIGH); // Turn a LED on
    digitalWrite(ledPins[index+3], HIGH); // Skip three, and turn that LED on
    delay(delayTime); //Pause to slow down the sequence
    digitalWrite(ledPins[index], LOW); // Turn the LED off 
    digitalWrite(ledPins[index+3], LOW); // Skip four, and turn that LED off
   }
}



