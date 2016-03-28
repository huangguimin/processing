
int max,Xe,Ye,Xs,Ys,Xn,Yn,X0,Y0,dir_x,dir_y;

void setup() 
{
  size(800, 800);
    background(0);
  fill(255);
  stroke(255,0,0);
  point(400,400);
  line(400,0,400,800);
  line(0,400,800,400);
  line(0,600,600,600);
  
  Xs = 0;
  Ys = 0;
  Xe = 0;
  Ye = 0;
  Xn = 0;
  Yn = 0;
}

int state = 0;
void mouseClicked() 
{
    fill(255,0,0);
    stroke(255,0,0);
    switch(state)
    {
      /*
      case 0:
        Xs = mouseX;
        Ys = mouseY;
        //Xn = 0;
        //Yn = 0;
        ellipse(Xs,Ys,4,4);
        print("Xs = " + Xs + " Ys = " + Ys + "\n");
        state = 1;
        break;*/
      case 0:
        Xe = mouseX;
        Ye = mouseY;
        Xn = 0;
        Yn = 0;
        ellipse(Xe,Ye,4,4);
        
        print("Xe = " + Xe + " Ye = " + Ye + "\n");
        state = 1;
                  
        Xe = Xe-Xs;
        Ye = Ye-Ys;
        
         if(Xe < 0)
         {
           dir_x = 1;
           Xe = -Xe;
         }
         else
           dir_x = 0;
           
         if(Ye < 0)
         {
           dir_y = 1;
           Ye = -Ye;
         }
         else
           dir_y = 0;
        max = Xe+Ye;
        count = 0;
        break;
      case 1:
        //state = 0;
        break;
    }
}
int count;
void draw() 
{    
 //translate(Xs, Ys);
 stroke(255);
 if(state == 1)
 {
   Xn = Xn + Xe;
   Yn = Yn + Ye;
   if(Xn >= max)
   {
      Xn = Xn - max;
      if(dir_x == 0)
        Xs++;
      else
        Xs--;
   }
   if(Yn >= max)
   {
      Yn = Yn - max;
      if(dir_y == 0)
        Ys++;
      else
        Ys--;
   }
   point(Xs,Ys);
   print("Xs = " + Xs + " Ys = " + Ys + "\n");
   print("max = " + max + "\n");
   if(max <= ++count)
   {
     state = 0;
   }
 } 
}