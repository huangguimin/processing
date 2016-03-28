



int max,Xe,Ye,Xs,Ys,Xc,Yc,Xn,Yn,X0,Y0,dir,F;

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
  Xe = 400;
  Ye = 600;
  X0 = 400;
  Y0 = 400;
  Xn = Xs;
  Yn = Ys;
  dir = 0;
  F = 0;
}

int state = 1;
void mouseClicked() 
{
    fill(255,0,0);
    stroke(255,0,0);
    switch(state)
    {/*
      case 0:
        F = 0;
        Xs = mouseX;
        Ys = mouseY;
        Xn = 0;
        Yn = 0;
        ellipse(Xs,Ys,4,4);
        print("Xs = " + Xs + " Ys = " + Ys + "\n");
        state = 1;
        break;*/
      case 1:
        Xe = mouseX;
        Ye = mouseY;
        Xn = 0;
        Yn = 0;
        F = 0;
        ellipse(Xe,Ye,4,4);
        print("Xe = " + Xe + " Ye = " + Ye + "\n");
        state = 2;
        break;
      case 2:
        Xc = mouseX;
        Yc = mouseY;
        ellipse(Xc,Yc,4,4);
        print("Xc = " + Xc + " Yc = " + Yc + "\n");
        dir = point3_Arc_center(Xe-Xs,Ye-Ys,Xc-Xs,Yc-Ys);
        fill(0,255,0);
        stroke(0,255,0);
        ellipse(X0+Xs,Y0+Ys,4,4);
        state = 3;
        if(Xe-(X0+Xs)>=0)
          a = 0;
        else
          a = 1;
        if(Ye-(Y0+Ys)>=0)
          b = 0;
        else 
          b = 1; 
          /*
        if(Xs-(X0+Xs)>=0)
          e = 0;
        else
          e = 1;
        if(Ys-(Y0+Ys)>=0)
          f = 0;
        else 
          f = 1; 
          */
        break;
      case 3:
        //state = 0;
        break;
    }
}

int a,b,c,d,e,f,state_end = 0;

float l1,l2;
int l3,l4;
int i = 0;
int point3_Arc_center(int x2,int y2,int x3,int y3) 
{
     int c,f,h;                   
        c=(x2*x2+y2*y2)/2;
        f=(x3*x3+y3*y3)/2;
        h=y3*x2-y2*x3;
        X0= (y3*c-y2*f)/h;
        Y0= (x2*f-x3*c)/h; 
        l2 = sqrt(pow((float)(x2-X0),2)+pow((float)(y2-Y0),2));
        l1 = sqrt(pow((float)X0,2)+pow((float)Y0,2));
        l3 = abs(x2-X0)+abs(y2-Y0);
        l4 = abs(X0)+abs(Y0);
        
        if((x2*y3 - y2*x3) > 0)
            return 1;
        else          
            return 0;
}

void draw() { 
 //translate(Xs, Ys);
 stroke(255);
 if(state == 3)
 {
     if(F >= 0)
     {
           if(dir == 0)
           {
                if(Xn >= X0&&Yn >= Y0)
                {
                   F = F-2*(Xn-X0)+1;
                   Xn--;
                }
                else if(Xn < X0&&Yn > Y0)
                {
                   F = F-2*(Yn-Y0)+1;
                   Yn--;
                }
                else if(Xn <= X0&&Yn <= Y0)
                {
                   F = F+2*(Xn-X0)+1;
                   Xn++;
                }
                else if(Xn > X0&&Yn < Y0)
                {
                   F = F+2*(Yn-Y0)+1;
                   Yn++;
                }
           }
           else
           {
                if(Xn > X0&&Yn > Y0)
                {
                   F = F-2*(Yn-Y0)+1;
                   Yn--;
                }
                else if(Xn <= X0&&Yn >= Y0)
                {
                   F = F+2*(Xn-X0)+1;
                   Xn++;
                }
                else if(Xn < X0&&Yn < Y0)
                {
                   F = F+2*(Yn-Y0)+1;
                   Yn++;
                }
                else if(Xn >= X0&&Yn <= Y0)
                {
                   F = F-2*(Xn-X0)+1;
                   Xn--;
                }
           }
     }
     else
     {
           if(dir == 0)
           {
               if(Xn >= X0&&Yn >= Y0)
                {
                   F = F+2*(Yn-Y0)+1;
                   Yn++;
                }
                else if(Xn < X0 && Yn > Y0)
                {
                   F = F-2*(Xn-X0)+1;
                   Xn--;
                }
                else if(Xn <= X0&&Yn <= Y0)
                {
                   F = F-2*(Yn-Y0)+1;
                   Yn--;
                }
                else if(Xn > X0&&Yn < Y0)
                {
                   F = F+2*(Xn-X0)+1;
                   Xn++;
                }
           }
           else
           {
                if(Xn > X0&&Yn > Y0)
                {
                   F = F+2*(Xn-X0)+1;
                   Xn++;
                }
                else if(Xn <= X0 && Yn >= Y0)
                {
                   F = F+2*(Yn-Y0)+1;
                   Yn++;
                }
                else if(Xn < X0&&Yn < Y0)
                {
                   F = F-2*(Xn-X0)+1;
                   Xn--;
                }
                else if(Xn >= X0&&Yn <= Y0)
                {
                   F = F-2*(Yn-Y0)+1;
                   Yn--;
                }
           }
     }
     point(Xs+Xn,Ys+Yn);
     print(Xn+" "+Yn+"\n");
     print("l1 = " + l1 + " l2 = " + l2 +"\n");
     print("l3 = " + l3 + " l4 = " + l4 +"\n");
     print("dir"+dir+"\n");
     
     if(Xn-X0>=0)
       c = 0;
     else
       c = 1;
     if(Yn-Y0>=0)
       d = 0;
     else
       d = 1;
     switch(state_end)
     {
       case 0:
         if(a == c && b == d)
         {
           max = abs(Xe-Xn-Xs)+abs(Ye-Yn-Ys);
           state_end = 1;
         }
         break;
       case 1:
         if(--max <= 0)
         {
           if(abs(Xe-Xn-Xs)+abs(Ye-Yn-Ys) <= 4)
           {
             state = 1;
             Xs = Xe;
             Ys = Ye;
           }
           state_end = 0;
         }
         break;
     }
 }
}