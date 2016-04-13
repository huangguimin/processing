// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 3-2: mouseX and mouseY
import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port


void setup() {
  size(640,360);
    
  String portName = Serial.list()[5];
  printArray(Serial.list());
  myPort = new Serial(this, portName, 38400);
  
}

float x = 0,y = 0;
void draw() {
  // Try moving background() to setup() and see the difference!
  background(0);

  // Body
  stroke(0,0,255);
  fill(255);
  rectMode(CORNER);
 
  x = 150;
  rect(x,y,50,50); 
  /* 
  if(x++>500)
    x = 0;
  if(y++>300)
    y = 0;*/
}
void serialEvent(Serial myPort) {
  y = myPort.read();
  print(y+"\n");
}