myline l1,l2;

void setup() {
  size(1200, 800);
  
  noStroke();
  l1 = new myline(40, 400, 410,0,255,0);
  l2 = new myline( 40-25, 400, 870,255,255,0); 
}

float move_angle = 0,move_lang = 0,A_B_lang = 870,rect_wight = 228.0; 

void draw() 
{
     background(0);
     noFill();
     stroke(255,0,0);
     rect(910,400-rect_wight/2,255,rect_wight);
     
     move_angle = atan2( rect_wight/2 -      (rect_wight - (mouseY-(400-rect_wight/2))),(mouseX-910)     +A_B_lang);
     move_lang = ((mouseX-910)     +A_B_lang)/cos(move_angle)-(A_B_lang-25);
     print("X_Point = " + (rect_wight - (mouseY-(400-rect_wight/2))) + "\n");
     
     print("Y_point  = " + (mouseX-910) + "\n");
     
     print("move_angle = " + move_angle*180/PI + "\n");
     print("move_lang  = " + move_lang + "\n");
     l1.angle = move_angle;
     l2.x = 40-cos(l1.angle)*(25-move_lang);
     l2.y = 400-sin(l1.angle)*(25-move_lang);
     l2.angle = l1.angle;

     l1.display();
     l2.display();
}
//mouseX
//mouseY
class myline {
  float x, y,x_end,y_end;
  float lang;
  float angle = 0.0;
  int colo_r = 255,colo_g = 255,colo_b = 255;
  
  myline(float tx, float ty, float tl,int tcolo_r, int tcolo_g, int tcolo_b) {
    x = tx;
    y = ty;
    lang = tl;
    colo_r = tcolo_r;
    colo_g = tcolo_g;
    colo_b = tcolo_b;
 }

  void update_xy(float mx, float my) {
    angle = atan2(my-y, mx-x);
  }
  
    void update_angle(float mangle) {
    angle = mangle*PI/180;
    x_end = cos(angle)*lang;
    y_end = sin(angle)*lang;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    stroke(255);
    line(0,0,lang,0);
    fill(colo_r, colo_g, colo_b);
    stroke(colo_r, colo_g, colo_b);
    ellipse(lang, 0, 10, 10);
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
}