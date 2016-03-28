void setup() {
  size(800, 800);
    background(0);
  fill(255);
  stroke(255,0,0);
  point(400,400);
  line(400,0,400,800);
  line(0,400,800,400);
  line(0,600,600,600);
  }

int sub_x = 0,sub_y = 0,x = 300,y = 200,max = 800; 
int all,i = 0,j = 0,state = 0,dir_x = 0,dir_y = 0;

int sub2_x = 0,sub2 = 0,Xc = 0,Yc = 0,X0 = 0,Y0 = 0,Xs = 100,Ys = 0,Xe = 0,Ye = 100,F = 0,R; 
int dir = 1;
void draw() { 
  //translate(400, 400);

 stroke(255);

 switch(state)
 {
    case 0:
      x = 300;
      y = 200;
      state = 1;
      break;
    case 1:
      x = 200;
      y = 100;
      state = 2;
      break;
    case 2:
      x = 400;
      y = 400;
      state = 3;
      break;
    case 3:
      state = 4;
      break;
    case 4:
       Xs = 400;
       Ys = 0;
       Xe = 0;
       Ye = 400;
       X0 = 0;
       Y0 = 0;
       //R = (int)sqrt(pow(Xs-X0,2)+pow(Ys-Y0,2));
       stroke(0,0,255);
       translate(400, 400);
       state = 5;
      break;
     case 5:
       Xs = 200;
       Ys = 0;
       Xe = 0;
       Ye = 200;
       X0 = 200;
       Y0 = 100;
       dir = 0;
       //R = (int)sqrt(pow(Xs-X0,2)+pow(Ys-Y0,2));
       stroke(0,255,0);
       translate(400, 400);
       state = 6;
       break;
     case 6:
       state = 7;
       break;
     case 7:
       state = 8;
       break;
 }
 
 x = x-i;
 y = y-j;
 if(x < 0)
 {
   dir_x = 1;
   x = -x;
 }
 else
   dir_x = 0;
 if(y < 0)
 {
   dir_y = 1;
   y = -y;
 }
 else
   dir_y = 0;
 all = x+y;
 max = all;
 while(all >= 0 && state <= 3)
 {
   sub_x = sub_x + x;
   sub_y = sub_y + y;
   if(sub_x >= max)
   {
      sub_x = sub_x - max;
      if(dir_x == 0)
        i++;
      else
        i--;
   }
   if(sub_y >= max)
   {
      sub_y = sub_y - max;
      if(dir_y == 0)
        j++;
      else
        j--;
   }
   point(i,j);
   all--;
 }
 
 
 Xc = Xs;
 Yc = Ys;
 max = abs(Ys-Ye)+abs(Xs-Xe)+X0 +Y0;
 F = 0;//(int)(pow(Xs-X0,2)+pow(Ys-Y0,2)-pow(R,2));
 while(max > 0 && state <= 6 && state >=5)
 {
     if(F >= 0)
     {
           if(dir == 0)
           {
                if(Xc >= X0&&Yc >= Y0)
                {
                   F = F-2*(Xc-X0)+1;
                   Xc--;
                }
                else if(Xc < X0&&Yc > Y0)
                {
                   F = F-2*(Yc-Y0)+1;
                   Yc--;
                }
                else if(Xc <= X0&&Yc <= Y0)
                {
                   F = F+2*(Xc-X0)+1;
                   Xc++;
                }
                else if(Xc > X0&&Yc < Y0)
                {
                   F = F+2*(Yc-Y0)+1;
                   Yc++;
                }
           }
           else
           {
                if(Xc > X0&&Yc > Y0)
                {
                   F = F-2*(Yc-Y0)+1;
                   Yc--;
                }
                else if(Xc <= X0&&Yc >= Y0)
                {
                   F = F+2*(Xc-X0)+1;
                   Xc++;
                }
                else if(Xc < X0&&Yc < Y0)
                {
                   F = F+2*(Yc-Y0)+1;
                   Yc++;
                }
                else if(Xc >= X0&&Yc <= Y0)
                {
                   F = F-2*(Xc-X0)+1;
                   Xc--;
                }
           }
     }
     else
     {
           if(dir == 0)
           {
               if(Xc >= X0&&Yc >= Y0)
                {
                   F = F+2*(Yc-Y0)+1;
                   Yc++;
                }
                else if(Xc < X0 && Yc > Y0)
                {
                   F = F-2*(Xc-X0)+1;
                   Xc--;
                }
                else if(Xc <= X0&&Yc <= Y0)
                {
                   F = F-2*(Yc-Y0)+1;
                   Yc--;
                }
                else if(Xc > X0&&Yc < Y0)
                {
                   F = F+2*(Xc-X0)+1;
                   Xc++;
                }
           }
           else
           {
                if(Xc > X0&&Yc > Y0)
                {
                   F = F+2*(Xc-X0)+1;
                   Xc++;
                }
                else if(Xc <= X0 && Yc >= Y0)
                {
                   F = F+2*(Yc-Y0)+1;
                   Yc++;
                }
                else if(Xc < X0&&Yc < Y0)
                {
                   F = F-2*(Xc-X0)+1;
                   Xc--;
                }
                else if(Xc >= X0&&Yc <= Y0)
                {
                   F = F-2*(Yc-Y0)+1;
                   Yc--;
                }
           }
     }
     point(Xc,Yc);
     //if(Xe == Xc && Ye == Yc)
       max--;
 }
 
 
 if(state == 8 && k != 3)
 {
   draw_cabu_circle(1,1);
 }
 //schedule(draw_cabu_circle(1,1), 0, 2000);
 //translate(400, 400);
 //line(0,0,400,200);
 }

int point3_Arc_center(float x1,float y1,float x2,float y2,float x3,float y3) 
{
   float a,b,c,d,e,f,g,h;
   
        a=(x2-x1);
        b=(y2-y1);                    
        g=x1*x1+y1*y1;
        c=(x2*x2+y2*y2-g)/2;
        d=(x3-x1);
        e=(y3-y1);
        f=(x3*x3+y3*y3-g)/2;
        h=e*a-b*d;
        X0=(int)((e*c-b*f)/h);
        Y0=(int)((a*f-d*c)/h); 
        
        if(((x2 - x1)*(y3 - y2) - (y2 - y1)*(x3 - x2)) > 0)
            return 1;
        else          
            return 0;
}



 int x0 = 400,y0 = 400; 
 int flag = 0,k = 0;
 int Fm,Xm = 600,Ym = 400;
 int Xend = 400,Yend = 600;
 int Max = abs(Xend - Xm) + abs(Yend - Ym);    

   void draw_cabu_circle(int sstep,int Directory)
   {
     //if(flag != 1)  
     {
           Fm=(Xm-x0)*(Xm-x0)+(Ym-y0)*(Ym-y0)-200*200;
           //Fm = Fm-2*Xm+1;
           if(Fm>=0)
           {
                if(Directory == 0)
                {  
                     if(Xm>=x0&&Ym<=y0)
                     {
                        if(flag == 1)    
                          k = 1;   
                         else       
                          Xm=Xm-sstep;
                      }
                      if(Xm<=x0&&Ym<=y0)
                      {
                        flag=1;      
                        Ym=Ym+sstep;
                      }
                       if(Xm<=x0&&Ym>=y0)
                          Xm=Xm+sstep;
                       if(Xm>=x0&&Ym>=y0)
                          Ym=Ym-sstep;
                }
                else  
                {                    /*it is Directory's else*/
                     if(Xm>x0&&Ym<y0)
                        Ym=Ym+sstep;
                     if(Xm<=x0&&Ym<=y0)
                        Xm=Xm+sstep;
                     if(Xm<x0&&Ym>y0) 
                     {
                        flag=1;     
                        Ym=Ym-sstep;
                     }
                     if(Xm>=x0 && Ym>=y0) 
                     {
                         if(flag == 1)  
                            k = 1;
                         Xm=Xm-sstep;
                     }
                }
           }
           else
           {        /*it is Fm's else*/
                if(Directory == 0) 
                {
                     if(Xm>x0&&Ym<y0) //<>//
                     {
                        if(flag == 1)    
                          k = 1;
                        else       
                          Ym=Ym-sstep;
                     }
                    if(Xm<=x0&&Ym<=y0)
                    {
                      flag=1;      
                      Xm=Xm-sstep;
                    }
                   if(Xm<=x0&&Ym>=y0)
                     Ym=Ym+sstep;
                   if(Xm>=x0&&Ym>=y0)
                     Xm=Xm+sstep;
                }
                else
                {
                    if(Xm>x0&&Ym<y0)
                      Xm=Xm+sstep;
                    if(Xm<=x0&&Ym<=y0)
                      Ym=Ym-sstep;
                     if(Xm<=x0&&Ym>=y0)
                     {
                        flag=1;           
                        Xm=Xm-sstep;
                      }
                     if(Xm>=x0&&Ym>=y0) 
                     {
                         if(flag == 1)  
                           k = 1;
                         else      
                           Ym=Ym+sstep;
                     }
                 }
             }
           stroke(255); //<>//
           point(Xm,Ym);
           //if(Max-- <= 0) 
           //  k = 1;
         }
     }