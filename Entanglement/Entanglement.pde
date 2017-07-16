int totalParticles = 60;

int minAmp = 70;
int maxAmp = 100;
int minPeriod = 100;
int maxPeriod = 200;
int ellipseSize = 20;
int count = 0;

Particle[] parray = new Particle[totalParticles];

void setup() {
  size(640,640);
  background(255);
  fill(0);
  smooth(4);
  frameRate(60);

// Particle(int iamplitude, int iperiod, float ixpos, float iypos, int idirection)  {
  for (int i = 0; i < parray.length; i++)  {
    parray[i] = new Particle(int(random(minAmp,maxAmp)),int(random(minPeriod,maxPeriod)),random(width),random(height),random(0,1));
  }
  
//Calculate initials for each parameter, to start normalizing against
  int sumAmplitude = 0;
  float meanAmplitude = 0.0;
  int sumPeriod = 0;
  float meanPeriod = 0.0;
  
  for (int i = 0; i < parray.length; i++) {
    Particle p = parray[i];
    int[] temp = p.getValues();
    sumAmplitude = sumAmplitude + temp[0];
    sumPeriod = sumPeriod + temp[1];
  }
  
  meanAmplitude = sumAmplitude * 1.0 / parray.length;
  meanPeriod = sumPeriod * 1.0 / parray.length;
  
  print("meanAmplitude = ");
  println(meanAmplitude);
  print("meanPeriod = ");
  println(meanPeriod);
 
}

void draw() {
  background(255);
  count++;
 
  for (int i = 0; i < parray.length; i++) {
    Particle p = parray[i];
    p.display();
    if (count%10 == 0)  {
      p.modAmp();
    }
  }
  //print("frameRate = ");
  //println(frameRate);
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

  int[] getValues()  {
    int[] values = new int[2];
    values[0] = amplitude;
    values[1] = period;
    return values;
  }

  void modAmp()  {
    if (amplitude > 0)  {
    amplitude = amplitude - 1;
    }
    else  {
      amplitude = 0;
    }
  }

}