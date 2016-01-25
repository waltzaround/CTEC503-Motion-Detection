
//Project Cronut
//Plays music based on quantity and length of motion detected by a camera.
//Outputs music and 360 degree rotating video onto a screen.

// With some code from:
// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Some code borrowed from Example 16-13: Simple motion detection

import processing.video.*;  //import video library to allow video input/output
import ddf.minim.*; // we need an audio library....

//music prerequisites
Minim minim; // declare minim as minim
AudioPlayer sound1; // declaring sound1 as an audioplayer
AudioPlayer sound2; // declaring sound2
AudioPlayer sound3; // declaring sound3
AudioPlayer sound4; // declaring sound4
AudioPlayer sound5; // declaring sound5
AudioPlayer sound6; // declaring sound6
AudioPlayer sound7; // declaring sound7
AudioPlayer sound8; // declaring sound8
AudioPlayer sound9; // declaring sound9
AudioPlayer sound10; // declaring sound10
AudioPlayer currentlyPlaying; // declaring audio that is currently playing
AudioInput input;

// Variable for capture device
Capture video; //ok computer, go get some video from the pc camera
// Previous Frame
PImage prevFrame; // draw the previous frame
PImage turnFrame; // draw the frame before the previous frame
PImage turnFrame1; // draw the frame before the above frame
PImage turnFrame2; // draw the frame before the above frame
PFont f; // declaring f as a font and to use f font
float theta = 80; // declare theta as 80
//int varInt = 0;
float varFloat = 1; // declare varFloat as a float and assign it the value 1
long timer ; // declare timer as a long datatype
long timer1 ; // declare timer1 as a long datatype
long timer2 ; // declare timer2 as a long datatype
long timer3 ; // declare timer3 as a long datatype
long interval = 50; // declare interval as a long datatype and assign it the value 50
int savedTime;
int totalTime = 5000; // 5 second timer
int totalTime1 = 10000; // 10 second timer
int totalTime2 = 15000; // 15 second timer
int totalTime3 = 20000; // 20 second timer
int totalTime4 = 25000; // 25 second timer
int totalTime5 = 30000; // 30 second timer
int totalTime6 = 60000; // 60 second timer

boolean sketchFullScreen() { // ok computer, whatever comes next decides whether its fullscreen or not
  return true; // make it fullscreen
}


// How different must a pixel be to be a "motion" pixel
float threshold = 14;

void setup() {
  size(1920, 1080);
  savedTime = millis();
  video = new Capture(this, 800, 600, 30);
  // Create an empty image the same size as the video
  prevFrame = createImage(video.width, video.height, RGB);
  //begin rotation images setup
  turnFrame = createImage(video.width, video.height, RGB);
  turnFrame1 = createImage(video.width, video.height, RGB);
  //end rotation images setup
  video.start();

  //begin font setup
  f = createFont("Arial", 16, true); // Arial, 16 point, anti-aliasing on
  //end font setup

  //Begin Timer
  timer = millis() + interval;//put timer in the future
  timer1 = millis() + interval;//put timer in the future
  timer2 = millis() + interval;//put timer in the future
  timer3 = millis() + interval;//put timer in the future
  //End Timer

  //begin music setup 
  minim = new Minim(this); 
  sound1 = minim.loadFile("Kick.wav"); // sound1 is a minim loaded with kick.wav in the data folder
  sound4 = minim.loadFile("SynthUpHigh.wav"); // sound1 is a minim loaded with SynthUpHigh.wav in the data folder
  sound2 = minim.loadFile("Snare01.wav"); // sound2 is a minim loaded with SynthUpHigh.wav in the data folder
  sound3 = minim.loadFile("TweekySynth.wav");
  sound5 = minim.loadFile("WampyPitchSound.wav");
  sound6 = minim.loadFile("KickBig.wav");
  sound7 = minim.loadFile("BigBass01.wav");
  sound8 = minim.loadFile("Snare02.wav");
  sound9 = minim.loadFile("MindControlTool.mp3");
  sound10 = minim.loadFile("night.mp3");
  input = minim.getLineIn();
  //end music setup
  sound1.loop();
  sound2.loop();
  sound3.loop();
  sound4.loop();
  sound5.loop();
  sound6.loop();
  sound7.loop();
  sound8.loop();
  sound9.loop();
  sound10.loop();
}

void draw() {

  // Capture video
  if (video.available()) {
    // Save previous frame for motion detection!!
    prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height); // Before we read the new frame, we always save the previous frame for comparison!
    turnFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height); // Before we read the new frame, we always save the previous frame for comparison!
    prevFrame.updatePixels();
    turnFrame.updatePixels();
    video.read();
  }

  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();
  turnFrame1.loadPixels();
  int moveQuantity = 0;
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {

      int loc = x + y*video.width;            // Step 1, what is the 1D pixel location
      color current = video.pixels[loc];      // Step 2, what is the current color
      color previous = prevFrame.pixels[loc]; // Step 3, what is the previous color

      // Step 4, compare colors (previous vs. current)
      float r1 = red(current); 
      float g1 = green(current); 
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous); 
      float b2 = blue(previous);
      float diff = dist(r1, g1, b1, r2, g2, b2);

      // Step 5, How different are the colors?
      // If the color at that pixel has changed, then there is motion at that pixel.
      if (diff > threshold) { 
        // If motion, display black
        turnFrame1.pixels[loc] = color(0);
        moveQuantity++;
      } else {
        // If not, display white
        turnFrame1.pixels[loc] = color(255);
      }
    }
  }
  updatePixels();
  turnFrame1.updatePixels();

  //begin triple image rotation
  if (timer < millis() ) {
    // varInt = varInt + 1;
    timer = millis() + interval;//put timer in the future
    theta += 10;
  }
  //image(a, 0, 0);

  pushMatrix();
  translate(+width/2, +height/2);
  rotate( radians ( theta ) );// 360 = 2 * PI
  translate(-width/2, -height/2);
  scale(2);
  image(turnFrame1, 0, 0); 
  popMatrix();



  if ( moveQuantity >= 0 && moveQuantity <= 8000) {
    sound1.mute();
    sound2.mute();
    sound3.mute();
    sound4.mute();
    sound5.mute();
    sound6.mute();
    sound7.mute();
    sound8.mute();
    sound9.mute();
    sound10.mute();
    savedTime = millis();
  }

  if ( moveQuantity > 8000 && moveQuantity <= 18000) {
    sound1.unmute();
    sound2.mute();
    sound3.mute();
    sound4.mute();
    sound5.mute();
    sound6.mute();
    sound7.mute();
    sound8.mute();
    sound9.mute();
    sound10.mute();
    savedTime = millis();
  }
  //
  //  if ( moveQuantity > 18000 && moveQuantity < 26000) {
  //    sound2.unmute();
  //    sound3.mute();
  //    sound4.unmute();
  //    sound1.unmute();
  //    sound5.mute();
  //    sound6.mute();
  //    sound7.mute();
  //    sound8.mute();
  //    sound9.mute();
  //    sound10.mute();
  //    savedTime = millis();
  //  } 


  if ( moveQuantity > 26000) {
    sound1.unmute();
    sound2.mute();
    sound3.mute();
    sound4.mute();
    sound6.mute();
    sound7.mute();
    sound8.mute();
    sound9.mute();
    sound10.mute();

    int passedTime = millis() - savedTime;


    if (passedTime >totalTime) {
      sound1.unmute();
      sound2.unmute();
      sound3.unmute();
      sound4.mute();
      sound6.mute();
      sound7.mute();
      sound8.mute();
      sound9.mute();
      sound10.mute();
    }

    passedTime = millis() - savedTime;

    if (passedTime >totalTime1) {
      sound1.mute();
      sound2.mute();
      sound3.mute();
      sound4.unmute();
      sound6.unmute();
      sound7.mute();
      sound8.mute();
      sound9.mute();
      sound10.mute();
    }

    passedTime = millis() - savedTime;

    if (passedTime >totalTime2) {
      sound1.mute();
      sound2.mute();
      sound3.mute();
      sound4.mute();
      sound5.mute();
      sound6.unmute();
      sound7.unmute();
      sound8.unmute();
      sound9.mute();
      sound10.mute();
    }

    passedTime = millis() - savedTime;


    if (passedTime >totalTime3) {
      sound1.unmute();
      sound2.mute();
      sound3.unmute();
      sound4.mute();
      sound5.mute();
      sound6.mute();
      sound7.mute();
      sound8.unmute();
      sound9.mute();
      sound10.mute();
    }

    passedTime = millis() - savedTime;

    if (passedTime >totalTime4) {
      sound1.mute();
      sound2.unmute();
      sound3.mute();
      sound4.mute();
      sound5.mute();
      sound6.unmute();
      sound7.unmute();
      sound8.mute();
      sound9.mute();
      sound10.mute();
    }

    passedTime = millis() - savedTime;

    if (passedTime >totalTime5) {
      sound1.mute();
      sound2.mute();
      sound3.mute();
      sound4.mute();
      sound5.mute();
      sound6.mute();
      sound7.mute();
      sound8.mute();
      sound9.unmute();
      sound10.mute();
    }

    passedTime = millis() - savedTime;

    if (passedTime >totalTime6) {
      sound1.mute();
      sound2.mute();
      sound3.mute();
      sound4.mute();
      sound5.mute();
      sound6.mute();
      sound7.mute();
      sound8.mute();
      sound9.mute();
      sound10.unmute();
    }
  }// end >26k movement if statement
  println(moveQuantity); // debugging
}// end void draw

