
import processing.video.*;
 
int numPixels;
int blockSize = 5 ;
Capture cam;
color myMovieColors[];
 
void setup() {
  size(640, 480, P2D);
  noStroke();
  background(0);

  
  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 640, 480);
  } 
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println("Camera " + i + ": " + cameras[i]);
    }

    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, cameras[1]);

    // Or, the settings can be defined based on the text in the list
    //video = new Capture(this, 640, 480, "Built-in iSight", 30);

    // Start capturing the images from the camera
    cam.start();
  }
  
  
  numPixels = width / blockSize;
  myMovieColors = new color[numPixels * numPixels];
}
 
// Read new values from movie
void captureEvent(Capture m) {
  m.read();
  m.loadPixels();
   
  for (int j = 0; j < numPixels; j++) {
    for (int i = 0; i < numPixels; i++) {
      myMovieColors[j*numPixels + i] = m.get(i*blockSize, j*blockSize);
    }
  }
}
 
// Display values from movie
void draw()  {
   
 //   if (cam.available() == true) {
 //   cam.read();
 //   image(cam, 0, 0);
 //   }
   
  for (int j = 0; j < numPixels; j++) {
    for (int i = 0; i < numPixels; i++) {
      fill(myMovieColors[j*numPixels + i]);
      rect(i*blockSize, j*blockSize, blockSize-1, blockSize-1);
    }
  }
}
