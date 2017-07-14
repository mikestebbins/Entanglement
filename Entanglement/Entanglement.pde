Particle p1, p2, p3, p4;
int minAmp = 70;
int maxAmp = 100;
int minPeriod = 100;
int maxPeriod = 200;
int ellipseSize = 20;

void setup() {
  size(640,640);
  background(255);
  fill(0);
  smooth(4);

//         Particle(int iamplitude, int iperiod, float ixpos, float iypos)  {
  p1 = new Particle(int(random(minAmp,maxAmp)),int(random(minPeriod,maxPeriod)),random(width),random(height));
  p2 = new Particle(int(random(minAmp,maxAmp)),int(random(minPeriod,maxPeriod)),random(width),random(height));
  p3 = new Particle(int(random(minAmp,maxAmp)),int(random(minPeriod,maxPeriod)),random(width),random(height));
  p4 = new Particle(int(random(minAmp,maxAmp)),int(random(minPeriod,maxPeriod)),random(width),random(height));
}

void draw() {
  background(255);
  p1.display();
  p2.display();
  p3.display();
  p4.display();
  //translate(width/2,height/2);
  //rotate(PI/3.0);
}

class Particle
{
  int amplitude;
  int period;
  float xpos;
  float ypos;
  
  Particle(int iamplitude, int iperiod, float ixpos, float iypos)  {
    amplitude = iamplitude;
    period = iperiod;
    xpos = ixpos;
    ypos = iypos;
  }

void display()  {
  float x;
  x = xpos + amplitude * cos(TWO_PI * frameCount / period);
  ellipse(x,ypos,ellipseSize,ellipseSize);
}
}