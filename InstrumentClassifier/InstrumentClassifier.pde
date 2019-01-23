import netP5.*;
import oscP5.*;
import processing.serial.*;

//Global Variables
Serial myPort;
OscP5 oscP5;
NetAddress dest;

void setup() {

// List all the available serial ports
printArray(Serial.list());
// Open the port to send data to microbit
myPort = new Serial(this, Serial.list()[2], 115200);

oscP5 = new OscP5(this,12000); //listen for OSC messages
dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator
println(oscP5);

}

void draw() {
  
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    if(theOscMessage.checkTypetag("f")) {
      float f = theOscMessage.get(0).floatValue();
       showMessage((int)f);
    }
  }
}

void showMessage(int i) {
    println(i);
    myPort.write(str(i));
}

void keyPressed() {
  //if(key == '1'){
  //  myPort.write("1,");
  //  print("1");
  //}
  myPort.write(str(key)+",");
  print(str(key)+",");
}
