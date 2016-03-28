import processing.serial.*;
Serial myPort;

myline l1,l2,l1_top,l2_top;
mylineToline ltol;

int windowsizex;
int windowsizey;

float time_x;
float time_z;
float time_y;
float move_speed = 0.8;

int state = 0;
void setup() {
  size(1450, 850);
  windowsizex = 1450;
  windowsizey = 850;
  mwin2x = windowsizex*9/10;
  mwin2y = windowsizey/2;
  
  noStroke();
  l1 = new myline( windowsizex/2, windowsizey/2, 270,0,255,0);
  l2 = new myline( windowsizex/2, windowsizey/2, 320,255,255,0); 
  l1_top = new myline( mwin2x, mwin2y, 270,0,255,0);  
  l2_top = new myline( mwin2x, mwin2y, 270,255,255,0);
  
  time_x = 0;
  time_z = 0;
  time_y = 0;
  
  ltol = new mylineToline(1,time_x,time_z,time_y,0,0,0,0);
  
  dobotSerialBegin();
}

int mwin2x,mwin2y;
float anglecount = 0,r = 100;

void draw() {
  float a1,a2,a3;
  
  background(0);
  fill(255);
  stroke(255);
  rect(windowsizex/2-20,windowsizey/2+10,40,60);
  fill(100);
  stroke(100);
  rect(mwin2x-20,mwin2y-20,40,40);
  fill(255,255,0);
  stroke(255,255,0);
  triangle(windowsizex/2-10,windowsizey/2+10, windowsizex/2+10,windowsizey/2+10, windowsizex/2,windowsizey/2);
  fill(255,0,0);
  stroke(255,0,0);
  ellipse(windowsizex/2, windowsizey/2, 10, 10);
  ellipse(mwin2x, mwin2y, 10, 10);
  
  //--------------------------------------//
  stroke(255);
  line(windowsizex/2+30,0,windowsizex/2+30,windowsizey);
  noFill();
  stroke(255,0,0);
  rect(windowsizex/2-225-300,windowsizey/2-25,300,200);
  rect(mwin2x-225-200,mwin2y-340,200,340);
  ellipse(windowsizex/2-225-r, windowsizey/2-25+r, 2*r, 2*r);
  ellipse(mwin2x-225-r, mwin2y-r, 2*r, 2*r);
  //---------------------------------------//
  
  l2.x = windowsizex/2+cos(l1.angle)*l1.lang;
  l2.y = windowsizey/2+sin(l1.angle)*l1.lang;
  l2_top.x = mwin2x+cos(l1_top.angle)*l1_top.lang;
  l2_top.y = mwin2y+sin(l1_top.angle)*l1_top.lang;
  /*
  if(mousePressed ==true)
  {
    ltol.update(-1,mouseX,mouseY,windowsizex/2,windowsizey/2,l2.lang,l1.lang);
    l1.update(ltol.n3_x, ltol.n3_y);
    l2.update(mouseX, mouseY);
  }
  */
 // if(frameCount%10 == 1)
 // {
   
    ltol.update(1,time_x,time_z,time_y,windowsizex/2,windowsizey/2,l1.lang,l2.lang);
    //l1.update_xy(ltol.n3_x, ltol.n3_y);
    //l2.update_xy(time_x, time_z);
    l1.angle = ltol.a1;
    l2.angle = ltol.a2;
    l1_top.angle = ltol.a3;
    l2_top.angle = ltol.a3;
    l1_top.lang = l1.lang*cos(l1.angle);
    l2_top.lang = l2.lang*sin(l2.angle+PI/2);
     switch(state)
     {
       case 0:
         if((time_z=time_z+move_speed)>200)
         {
           state = 1;
         }
         break;
       case 1:
         if((time_x=time_x+move_speed)>300)
         {
           state = 2;
         }
         break;
       case 2:
         if((time_z=time_z-move_speed)<=0)
         {
           time_z = 0;
           state = 3;
         }
         break;
       case 3:
         if((time_x=time_x-move_speed)<=0)
         {
           time_x = 0;
           state = 4;
         }
         break;
       case 4:
         if((time_y=time_y+move_speed)>340)
         {
           state = 5;
         }
         break;
       case 5:
         if((time_x=time_x+move_speed)>200)
         {
           state = 6;
         }
         break;
       case 6:
         if((time_y=time_y-move_speed)<=0)
         {
           time_y = 0;
           state = 7;
         }
         break;
       case 7:
         if((time_x=time_x-move_speed)<=0)
         {
           time_x = 0;
           state = 8;
         }
         break;
       case 8:
         if((time_z=time_z+move_speed)>100)
         {
           state = 9;
         }
         break;
       case 9:
         if((anglecount = anglecount+move_speed)>360) //<>//
         {
           state = 10;
           anglecount = 0;
         }
         time_x = r-r*cos(anglecount*PI/180); //<>//
         time_z = r+r*sin(anglecount*PI/180); //<>//
         break;
       case 10:
         if((time_y=time_y+move_speed)>100)
         {
           state = 11;
         }
         break;
       case 11:
         if((anglecount = anglecount+move_speed)>360)
         {
           state = 12;
           anglecount = 0;
         }
         time_x = r-r*cos(anglecount*PI/180);
         time_y = r+r*sin(anglecount*PI/180);
         break;
       case 12:
         if((time_y=time_y-move_speed)<=0)
         {
           time_y = 0;
           state = 13;
         }
         break;
       case 13:
         exit();
         break;
     }
    l1.display();
    l2.display();
    l1_top.display();
    l2_top.display();
    
    a1 = (267-(l1.angle*180/PI));
    a2 = -130+(l2.angle*180/PI);
    a3 = (ltol.a3*180/PI);
    //sendPackage((int)(a1*2.3),(int)(a2),(int)(a3));
    //print("l1 angle = " + a1 + "  " + "l2 angle = " + a2 + "  " +  "a3 angle = " + a3 +"\n");
    print("l1 angle = " + Integer.toHexString((int)(a1*270)) + "  " + "l2 angle = " + Integer.toHexString((int)(a2*270)) + "  " +  "a3 angle = " + Integer.toHexString((int)(a3*270)) +"\n");
    sendPackage((int)(a1*270),(int)(a2*270),(int)(a3*270));
  //delay(500);
}

int CRC16(byte [] bytes,int len)  
{    
        int[] table = { 
            0x0000, 0xC0C1, 0xC181, 0x0140, 0xC301, 0x03C0, 0x0280, 0xC241, 
            0xC601, 0x06C0, 0x0780, 0xC741, 0x0500, 0xC5C1, 0xC481, 0x0440, 
            0xCC01, 0x0CC0, 0x0D80, 0xCD41, 0x0F00, 0xCFC1, 0xCE81, 0x0E40, 
            0x0A00, 0xCAC1, 0xCB81, 0x0B40, 0xC901, 0x09C0, 0x0880, 0xC841, 
            0xD801, 0x18C0, 0x1980, 0xD941, 0x1B00, 0xDBC1, 0xDA81, 0x1A40, 
            0x1E00, 0xDEC1, 0xDF81, 0x1F40, 0xDD01, 0x1DC0, 0x1C80, 0xDC41, 
            0x1400, 0xD4C1, 0xD581, 0x1540, 0xD701, 0x17C0, 0x1680, 0xD641, 
            0xD201, 0x12C0, 0x1380, 0xD341, 0x1100, 0xD1C1, 0xD081, 0x1040, 
            0xF001, 0x30C0, 0x3180, 0xF141, 0x3300, 0xF3C1, 0xF281, 0x3240, 
            0x3600, 0xF6C1, 0xF781, 0x3740, 0xF501, 0x35C0, 0x3480, 0xF441, 
            0x3C00, 0xFCC1, 0xFD81, 0x3D40, 0xFF01, 0x3FC0, 0x3E80, 0xFE41, 
            0xFA01, 0x3AC0, 0x3B80, 0xFB41, 0x3900, 0xF9C1, 0xF881, 0x3840, 
            0x2800, 0xE8C1, 0xE981, 0x2940, 0xEB01, 0x2BC0, 0x2A80, 0xEA41, 
            0xEE01, 0x2EC0, 0x2F80, 0xEF41, 0x2D00, 0xEDC1, 0xEC81, 0x2C40, 
            0xE401, 0x24C0, 0x2580, 0xE541, 0x2700, 0xE7C1, 0xE681, 0x2640, 
            0x2200, 0xE2C1, 0xE381, 0x2340, 0xE101, 0x21C0, 0x2080, 0xE041, 
            0xA001, 0x60C0, 0x6180, 0xA141, 0x6300, 0xA3C1, 0xA281, 0x6240, 
            0x6600, 0xA6C1, 0xA781, 0x6740, 0xA501, 0x65C0, 0x6480, 0xA441, 
            0x6C00, 0xACC1, 0xAD81, 0x6D40, 0xAF01, 0x6FC0, 0x6E80, 0xAE41, 
            0xAA01, 0x6AC0, 0x6B80, 0xAB41, 0x6900, 0xA9C1, 0xA881, 0x6840, 
            0x7800, 0xB8C1, 0xB981, 0x7940, 0xBB01, 0x7BC0, 0x7A80, 0xBA41, 
            0xBE01, 0x7EC0, 0x7F80, 0xBF41, 0x7D00, 0xBDC1, 0xBC81, 0x7C40, 
            0xB401, 0x74C0, 0x7580, 0xB541, 0x7700, 0xB7C1, 0xB681, 0x7640, 
            0x7200, 0xB2C1, 0xB381, 0x7340, 0xB101, 0x71C0, 0x7080, 0xB041, 
            0x5000, 0x90C1, 0x9181, 0x5140, 0x9301, 0x53C0, 0x5280, 0x9241, 
            0x9601, 0x56C0, 0x5780, 0x9741, 0x5500, 0x95C1, 0x9481, 0x5440, 
            0x9C01, 0x5CC0, 0x5D80, 0x9D41, 0x5F00, 0x9FC1, 0x9E81, 0x5E40, 
            0x5A00, 0x9AC1, 0x9B81, 0x5B40, 0x9901, 0x59C0, 0x5880, 0x9841, 
            0x8801, 0x48C0, 0x4980, 0x8941, 0x4B00, 0x8BC1, 0x8A81, 0x4A40, 
            0x4E00, 0x8EC1, 0x8F81, 0x4F40, 0x8D01, 0x4DC0, 0x4C80, 0x8C41, 
            0x4400, 0x84C1, 0x8581, 0x4540, 0x8701, 0x47C0, 0x4680, 0x8641, 
            0x8201, 0x42C0, 0x4380, 0x8341, 0x4100, 0x81C1, 0x8081, 0x4040, 
        }; 
 
        int crc = 0xffff,i = 0; 
         
        while(len > i)
        { 
            crc = (crc >> 8) ^ table[(crc ^ bytes[i++]) & 0xff];
        } 
        return crc; 
}

void dobotSerialBegin()
{
  if (Serial.list().length > 0)
  {
    String portName = "COM7";//Serial.list()[0];
    myPort = new Serial(this, portName, 115200);//128000
    //myPort.bufferUntil(0x5a);
  }
}
int count = 0;
void sendPackage(int a1,int a2,int a3)
{
  int crctemp,i,j,en = 0;

  byte[] send = new byte[8];
  int[] recv = new int[8];
 do
 {
    send[1] = (byte)a1;
    send[0] = (byte)(a1>>8);
    send[3] = (byte)a2;
    send[2] = (byte)(a2>>8);
    send[5] = (byte)a3;
    send[4] = (byte)(a3>>8);
    crctemp = CRC16(send,6);
    send[7] = (byte)crctemp;
    send[6] = (byte)(crctemp>>8);
    //myPort.write(byte(0xfe)); //the package head
    for (i =0; i<8; i++)
    {
      myPort.write(send[i]);
    }
    
    print("Send CRC16 = " + Integer.toHexString(crctemp)+"\n" + "Receive Datas = ");
    //delay(1);
    
    for (j =0; j<i;) //<>//
    {
        if(myPort.available() > 0)
        {
        // If data is available,
          recv[j] = myPort.read();
          print(Integer.toHexString(recv[j]));         // read it and store it in val 
          j++;
        }
        print(" ");
    }
    
    print("\n"+"Send frame number = "+frameCount + " Erro frame number = "+count+"\n");
    
    if((recv[0] == 0x0ff)&&(recv[1] == 0x0ff)&&(recv[2] == 0x0ff)&&(recv[3] == 0x0ff)&&(recv[4] == 0x0ff)&&(recv[5] == 0x0ff))
    {
      en = 0;
      delay(10);
      count++;
     }
    else
      en = 1;
   }while(en == 0);
}

class mylineToline
{
    float m,n1_x,n1_z,n1_y,n2_x,n2_y,n3_x,n3_y;    
    float r1,r2;
    float a1,a2,a3;
    float x,y,z;
    
    mylineToline(int mm,float n1x,float n1z,float n1y,float n2x,float n2y,float r_1,float r_2) 
    {
      m = mm;
      x = n1x+225;
      n1_x = windowsizex/2 - sqrt(pow(n1y,2)+pow(x,2));
      n1_z = windowsizey/2 - 25 + n1z;
      z = n1z;
      n1_y = n1y;
      y = n1y;
      n2_x = n2x;
      n2_y = n2y;  
      r1   = r_1;
      r2   = r_2;
      calcu();
    }
    void update(int mm,float n1x,float n1z,float n1y,float n2x,float n2y,float r_1,float r_2) 
    {
      m = mm;
      x = n1x+225;
      n1_x = windowsizex/2 - sqrt(pow(n1y,2)+pow(x,2));
      n1_z = windowsizey/2 - 25 + n1z;
      z = n1z;
      n1_y = n1y;
      y = n1y;
      n2_x = n2x;
      n2_y = n2y;  
      r1   = r_1;
      r2   = r_2;
      calcu();
    }
    void calcu()    
    { 
      float delx,dely,phi,ssq,s,test1,test2,cosin,alpha,theta; 
         
      delx=n2_x-n1_x; 
      if(abs(delx)<=0.0000000001)
        delx=0.0000000001;    
      dely=n2_y-n1_z;    
      phi=atan2(dely,delx); 
      ssq=pow((n2_x-n1_x),2)+pow((n2_y-n1_z),2);    
      s=sqrt(ssq);    
      test1=s-(r1+r2);    
      test2=abs(r1-r2)-s; 
      if((test1<=0.0)&&(test2<=0.0))     
      { 
        cosin=(r1*r1+ssq-r2*r2)/(2.0*r1*s);       
        alpha=atan2(sqrt(1.0-cosin*cosin),cosin);       
        if(m<0)  
           theta=phi-alpha; 
        else  
           theta=phi+alpha; 
           n3_x=n1_x+r1*cos(theta);       
           n3_y=n1_z+r1*sin(theta);  
           a1=PI+atan2((n3_y-n1_z),(n3_x-n1_x));       
           a2=atan2((n3_y-n2_y),(n3_x-n2_x)); 
           //a3=acos((float)(y)/(float)(x));
           a3=atan2(y,x);
      }    
      else 
      {
        print("The dyad cannot be assembled!\n");         
      }  
    }
}

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
    popMatrix();
  }
}