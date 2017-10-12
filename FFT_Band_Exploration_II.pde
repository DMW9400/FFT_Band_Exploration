import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];

void setup() {
  size(500,500);
  //fullScreen();
  background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
}      

void drawBass(){
  fft.analyze(spectrum);
  float bassBand = map(spectrum[1],0,.1,0,255);
  rect(90,50,100,100);
  fill(bassBand);
}

void drawTreble(){
  fft.analyze(spectrum);
  float trebleBand = map(spectrum[40],0,.01,0,255);
  rect(350,50,30,30);
  fill(trebleBand);
} 

void draw() { 
  background(255);
 
  
  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  line( i, height, i, height - spectrum[i]*height*5 );
  //draw bass-responsive rectangle
  
  //System.out.println(bassBand);
  //draw treble-responsive rectangle
  drawBass();
  drawTreble();

  
  //println(bandVol);
  }
}