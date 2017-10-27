final int MAX_FREQ = 6;
final int PHASE_DIV = 12;
final float MIN_DAMP = 0.005;
final float MAX_DAMP = 0.01;
final float DT = 0.02;

float ampliX1, ampliX2, ampliY1, ampliY2;
float freqX1, freqX2, freqY1, freqY2;
float phaseX1, phaseX2, phaseY1, phaseY2;
float dampX1, dampX2, dampY1, dampY2;

float x, y, t;

void setup() {
  size(600, 600);
  background(255);
  randomInit();
  step();
}

void draw() {
  float oldX = x;
  float oldY = y;
  step();
  line(mapX(oldX), mapY(oldY), mapX(x), mapY(y));
}

void mousePressed() {
  save("curve.png");
}

void randomInit() {
  ampliX1 = random(1);
  ampliX2 = 1 - ampliX1;
  ampliY1 = random(1);
  ampliY2 = 1 - ampliY1;
  
  freqX1 = 1 + int(random(MAX_FREQ));
  freqX2 = 1 + int(random(MAX_FREQ));
  freqY1 = 1 + int(random(MAX_FREQ));
  freqY2 = 1 + int(random(MAX_FREQ));
  println(freqX1 + " " + freqX2 + " " + freqY1 + " " + freqY2);
  
  phaseX1 = 0;
  phaseX2 = int(random(PHASE_DIV)) * TWO_PI / PHASE_DIV;
  phaseY1 = int(random(PHASE_DIV)) * TWO_PI / PHASE_DIV;
  phaseY2 = int(random(PHASE_DIV)) * TWO_PI / PHASE_DIV;
  
  dampX1 = random(MIN_DAMP, MAX_DAMP);
  dampX2 = random(MIN_DAMP, MAX_DAMP);
  dampY1 = random(MIN_DAMP, MAX_DAMP);
  dampY2 = random(MIN_DAMP, MAX_DAMP);
}

float dampSin(float t, float ampli, float freq, float phase, float damp) {
  return ampli * sin(t * freq + phase) * exp(-damp * t);
}

void step() {
  x = dampSin(t, ampliX1, freqX1, phaseX1, dampX1) + dampSin(t, ampliX2, freqX2, phaseX2, dampX2);
  y = dampSin(t, ampliY1, freqY1, phaseY1, dampY1) + dampSin(t, ampliY2, freqY2, phaseY2, dampY2);
  t += DT;
}

float mapX(float x) {
  return map(x, -(ampliX1 + ampliX2), ampliX1 + ampliX2, 0, width);
}

float mapY(float y) {
  return map(y, -(ampliY1 + ampliY2), ampliY1 + ampliY2, height, 0);
}