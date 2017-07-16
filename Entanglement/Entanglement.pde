int totalParticles = 100;
int circleSize = 20;
int backgroundColor = 255;
int circleColor = 50;

float incrementStep = 0.005;
int minAmp = 70;
int maxAmp = 100;
int minPeriod = 100;
int maxPeriod = 200;
float minPhase = -3.14;
float maxPhase = 3.14;

int count = 0;
float sumAmplitude = 0.0;
float meanAmplitude = 0.0;
float sumPeriod = 0.0;
float meanPeriod = 0.0;
float sumPhase = 0.0;
float meanPhase = 0.0;

Particle[] parray = new Particle[totalParticles];

//-----------------------------------------------------------------------------
void setup() {
  size(640,640);
  background(backgroundColor);
  fill(circleColor);
  stroke(circleColor);
  smooth(4);
  frameRate(60);

  for (int i = 0; i < parray.length; i++)  {
    float amplitude = random(minAmp,maxAmp);
    float period = random(minPeriod,maxPeriod);
    float phase = random(minPhase,maxPhase);
    float xpos = random(width);
    float ypos = random(height);
    
    parray[i] = new Particle(amplitude,period,phase,xpos,ypos);
  }
  
//Calculate averages for each parameter, to start modifying each particle towards
  for (int i = 0; i < parray.length; i++) {
    Particle p = parray[i];
    float[] temp = p.getValues();
    sumAmplitude = sumAmplitude + temp[0];
    sumPeriod = sumPeriod + temp[1];
    sumPhase = sumPhase + temp[2];
  }
  
  meanAmplitude = sumAmplitude * 1.0 / parray.length;
  meanPeriod = sumPeriod * 1.0 / parray.length;
  meanPhase = sumPhase * 1.0 / parray.length;
  
  print("meanAmplitude = ");
  println(meanAmplitude);
  print("meanPeriod = ");
  println(meanPeriod);
  print("meanPhase = ");
  println(meanPhase);
}

//-----------------------------------------------------------------------------
void draw() {
  background(backgroundColor);
  count++;
 
  for (int i = 0; i < parray.length; i++) {
    Particle p = parray[i];
    
    float[] temp = p.getValues();
    float currentAmplitude = temp[0];
    float currentPeriod = temp[1];
    float currentPhase = temp[2];
    
    float newAmplitude = currentAmplitude - ((currentAmplitude - meanAmplitude) * incrementStep);  
    float newPeriod = currentPeriod - ((currentPeriod - meanPeriod) * incrementStep);
    float newPhase = currentPhase - ((currentPhase - meanPhase) * incrementStep);
    
    //print("newAmplitude = ");
    //println(newAmplitude);
    //print("newPeriod = ");
    //println(newPeriod);
    //print("newPhase = ");
    //println(newPhase);
    
    p.modifyAmplitude(newAmplitude);
    p.modifyPeriod(newPeriod);   
    p.modifyPhase(newPhase);
    
    p.display();

  print("frameRate = ");
  println(frameRate);
  }
}

//-----------------------------------------------------------------------------
class Particle
{
  float amplitude;
  float period;
  float phase;
  float xpos;
  float ypos;
  float direction;
  
  Particle(float iamplitude, float iperiod, float iphase, float ixpos, float iypos)  {
    amplitude = iamplitude;
    period = iperiod;
    phase = iphase;
    xpos = ixpos;
    ypos = iypos;
  }
  
  void display()  {
    float x;
    x = xpos + amplitude * cos(TWO_PI * (frameCount + phase) / period);
    ellipse(x,ypos,circleSize,circleSize);
  }

  float[] getValues()  {
    float[] values = new float[3];
    values[0] = amplitude;
    values[1] = period;
    values[2] = phase;
    return values;
  }

  void modifyAmplitude(float newAmplitude)  {
    amplitude = newAmplitude;
  }
  void modifyPeriod(float newPeriod)  {
    period = newPeriod;
  }
  void modifyPhase(float newPhase)  {
    phase = newPhase;
  }

}