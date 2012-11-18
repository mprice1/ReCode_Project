void setup() {
  size(512,512);
}

final float BASE_ANIMAL_SCALE = 100.0;
final float TUNNEL_RADIUS = 50;
// TODO: This is just a blobby shape. Make actual images...
final float[][] FROG = 
{{0.41601562,0.62109375},
{0.328125,0.6894531},
{0.27148438,0.6308594},
{0.27539062,0.53125},
{0.35351562,0.5527344},
{0.40820312,0.46289062},
{0.37695312,0.36328125},
{0.47460938,0.2734375},
{0.5410156,0.27539062},
{0.5546875,0.34960938},
{0.5683594,0.390625},
{0.6425781,0.40429688},
{0.6953125,0.38476562},
{0.7128906,0.33203125},
{0.7246094,0.29296875},
{0.7910156,0.27929688},
{0.84375,0.29296875},
{0.8847656,0.34960938},
{0.8808594,0.41015625},
{0.8613281,0.4765625},
{0.90234375,0.546875},
{0.9277344,0.58984375},
{0.91015625,0.6894531},
{0.8046875,0.73046875},
{0.71484375,0.671875},
{0.6171875,0.65234375},
{0.5800781,0.6953125},
{0.51953125,0.73046875},
{0.4375,0.70703125},
{0.42382812,0.66015625},
{0.41601562,0.6191406}};

void drawAnimal(float[][] pts) {
  beginShape();
  for(int i = 0; i < pts.length; i++) {
    vertex(BASE_ANIMAL_SCALE*pts[i][0] - BASE_ANIMAL_SCALE/2,
           BASE_ANIMAL_SCALE*pts[i][1] - BASE_ANIMAL_SCALE/2); 
  }
  endShape(CLOSE); 
}

void transformToTunnelPoint() {
   float theta, zz, r, dx, dy, tx, ty, tunneldist;
   do {
     theta = random(TWO_PI);
     // Bastardization of perspective transform.
     zz = random(5) + 1.0;
     r = height/2 + TUNNEL_RADIUS;
     dx = r * cos(theta) / zz;
     dy = r * sin(theta) / zz;
     tx = width/2 + dx;
     ty = height/2 + dy;
     tunneldist = sqrt(dx*dx + dy*dy);
     // Rejection sampling.
   } while (tunneldist < TUNNEL_RADIUS);
   
   translate(tx, ty);
   
   float persp = (tunneldist - TUNNEL_RADIUS + 25) / (height/2);
   // Persepective attentuation.
   float angle = atan2(dy, dx);
   rotate(angle);
   scale(persp*persp*persp*2, persp);
   rotate(-angle);
   
   // Random rotation.
   rotate(random(2*PI));
}

void draw() {
  background(0xffffff);
  for (int i = 0; i < 300; i++) {
    pushMatrix();
     transformToTunnelPoint();
     drawAnimal(FROG);
    popMatrix(); 
  }
  noLoop();
}
