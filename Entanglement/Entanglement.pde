int totalParticles = 50;

int minAmp = 70;
int maxAmp = 100;
int minPeriod = 100;
int maxPeriod = 200;
int ellipseSize = 20;


Particle[] parray = new Particle[totalParticles];

void setup() {
  size(640,640);
  background(255);
  fill(0);
  smooth(4);

//         Particle(int iamplitude, int iperiod, float ixpos, float iypos, int idirection)  {
  for (int i = 0; i < parray.length; i++)  {
    parray[i] = new Particle(int(random(minAmp,maxAmp)),int(random(minPeriod,maxPeriod)),random(width),random(height),random(0,1));
  }
}

void draw() {
  background(255);


  
  for (int i = 0; i < parray.length; i++) {
    Particle p = parray[i];
    p.display();
  }
  
  //translate(width/2,height/2);
  //rotate(PI/3.0);
}

class Particle
{
  int amplitude;
  int period;
  float xpos;
  float ypos;
  float direction;
  
  Particle(int iamplitude, int iperiod, float ixpos, float iypos, float idirection)  {
    amplitude = iamplitude;
    period = iperiod;
    xpos = ixpos;
    ypos = iypos;
    direction = idirection;
  }

void display()  {
  float x;
  float sign;
  if (direction >= 0.5) {sign = 1;}
  else {sign = -1;}
  x = xpos + sign * amplitude * cos(TWO_PI * frameCount / period);
  ellipse(x,ypos,ellipseSize,ellipseSize);
}

}