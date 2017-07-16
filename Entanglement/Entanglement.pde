int totalParticles = 500;
int circleSize = 4;
int backgroundColor = 255;
int circleColor = 0;

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

PVector[] activeCircles = new PVector[totalParticles];
PVector[] candidateCircles = new PVector[totalParticles];

Particle[] parray = new Particle[totalParticles];

//-----------------------------------------------------------------------------
void setup() {
  size(640,640);
  background(backgroundColor);
  fill(circleColor);
  stroke(circleColor);
  smooth(4);
  frameRate(60);
  
  evenDistributedRandomPoints();
  println("Made it here");

  for (int i = 0; i < parray.length; i++)  {
    PVector temp = activeCircles[i];
    
    float amplitude = random(minAmp,maxAmp);
    float period = random(minPeriod,maxPeriod);
    float phase = random(minPhase,maxPhase);
    float xpos = temp.x;
    float ypos = temp.y;
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
  }
  //print("frameRate = ");
  //println(frameRate);
  print("frameCount = ");
  println(frameCount);
  
  //// Saves each frame as line-000001.png, line-000002.png, etc.
  //saveFrame("line-######.png");
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

//-----------------------------------------------------------------------------
// from random circles with mitchells best candidate algorithm for seeding dots
void evenDistributedRandomPoints ()  {

  int counter = 0; 
  
  while (counter < totalParticles)  {
    
    if (counter == 0)  {
      activeCircles[counter] = new PVector(random(-maxAmp, width + maxAmp),random(-maxAmp, height + maxAmp));  
      float[] f = activeCircles[counter].array();
      counter++;
    }
    
    if ((counter != 0) && (counter < totalParticles))  {
      //Generate new random coords arrays
      for (int i = 0; i < totalParticles; i++)  {
        candidateCircles[i] = new PVector(random(-maxAmp, width + maxAmp),random(-maxAmp, height + maxAmp));
      }
      //For each of the new candidate points, test it's distance from each existing point
      float maxDist = 0;
      int maxDistIndex = 9999;
      
      for (int i = 0; i < totalParticles; i++)  {    
        float minDist = 9999;
        int minDistIndex = 9999;
        
        for (int j = 0; j < counter; j++)  {      
          PVector v1 = candidateCircles[i];      
          PVector v2 = activeCircles[j];
          
          float dist = PVector.dist(v1,v2);
          
          if (dist < minDist)  {
            minDist = dist;
            minDistIndex = j;
          }
        }
        
        if (minDist >= maxDist)  {
          maxDist = minDist;
          maxDistIndex = i;  
        }
      }
      
      PVector keeper = candidateCircles[maxDistIndex];
      activeCircles[counter] = keeper;
      float[] f = activeCircles[counter].array();
      counter++;
    }
  }  
}