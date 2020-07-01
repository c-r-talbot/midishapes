

import themidibus.*;
MidiBus myBus;
boolean notePressed = false;
//NoteShape[][] channels = 
NoteShape channel1[] = new NoteShape[4];
NoteShape channel2[] = new NoteShape[4];
NoteShape channel3[] = new NoteShape[4];
NoteShape channel4[] = new NoteShape[4];
NoteShape[][] channels = {channel1, channel2, channel3, channel4};
int bbindex = 0;
int bgr = 0;
int bgg = 0;
int bgb = 0;
int beat_clock;
boolean trigger;
float xquad;
float yquad;

NoteShape pp;

void setup(){
  size(1600,900);
  myBus.list();
  myBus = new MidiBus(this,"Bus 1",-1);
  surface.setResizable(true);
  surface.setLocation(100, 100);
  xquad = width/4;
  yquad = height/4;
}

void draw() {
  xquad = width/4;
  yquad = height/4;
  //frameRate(60);
  //background(255);
  if(beat_clock == 256){
     bgr = 0;
     bgb = 0;
     bgg = 0;
     beat_clock=0;
  }
  //println(beat_clock);
  background(bgr,bgg,bgb);
  for(int channel = 0; channel < channels.length; channel++){
   for(int i = 0; i < channels[channel].length; i++){
      NoteShape newNote = channels[channel][i];
      if(newNote != null){ 
        newNote.display();
        if(newNote.channel == 0 ){
          //println("channel0 in loop");
          //background(0);
        }
        if(newNote.channel == 1 ){
          //println("channel1 in loop");
          //background(0);
        }
      }
    }  
  }
  if(mousePressed){ 
    background(255);
  }

} 


class NoteShape {
  PShape p;
  float x,y;
  float red;
  float green;
  float blue;
  int pitch;
  int channel;
  NoteShape(Note note){
    this.pitch=note.pitch();
    this.channel=note.channel();
    //println("NoteShape Pitch:"+note.pitch());
    
    
    switch(this.channel){
      case 1:
        //this.red = random(100,120);
        //this.blue = random(200);
        //this.green = 0;
        //this.x = xquad;
        //this.y = yquad;
        //p = createShape(RECT,x,y,100,100);
        //p.setFill(color(red,green,blue));
        //p.setStroke((color(random(255),random(255),random(255))));
        
        x = random(100,width-100);
        y = random(100,height-100);
        p = createShape();
        p.beginShape();
        p.fill(random(255),random(255),random(255));
        p.stroke(random(255),random(255),random(255));
        p.vertex(random(width), random(height));
        p.vertex(random(width), random(width));
        p.vertex(random(width), random(height));
        p.vertex(random(width), random(height));
        // The shape is complete
        p.endShape(CLOSE); 
        break;
        
      case 0:
        this.red = random(255);
        this.blue = random(255);
        this.green = random(30);
        this.x = xquad*2;
        this.y = yquad*2;
        p = createShape(ELLIPSE,x,y,random(200,300),random(200,300));
        p.setFill(color(red,green,blue));
        p.setStroke((color(random(255),random(255),random(255))));
        break;
      
      case 2:
        this.red = 0;
        this.blue = random(10,100);
        this.green = random(10,100);
        this.x = xquad*2;
        this.y = yquad*2;
        rectMode(CENTER);
        p = createShape(RECT,x,y,random(100),100);
        p.setFill(color(red,green,blue));
        p.setStroke((color(random(255),random(255),random(255))));
        break;
        
      case 3:
        this.red = random(255);
        this.blue = random(10,200);
        this.green = random(10,100);
        this.x = xquad*2;
        this.y = yquad*2;
        rectMode(CENTER);
        p = createShape(RECT,x,y,random(20),random(30));
        p.setFill(color(red,green,blue));
        p.setStroke((color(random(255),random(255),random(255))));
        break;
    }
    
    //x = random(100,width-100);
    //y = random(100,height-100);
    //p = createShape();
    //p.beginShape();
  //  p.vertex(random(width), random(height));
  //  p.vertex(random(width), random(width));
  //  p.vertex(random(width), random(height));
  //  p.vertex(random(width), random(height));
  //  // The shape is complete
    //p.endShape(CLOSE); 
  }
  
  void display(){
    shape(p);
  }
}



void noteOn(Note note){
  //notePressed = true;
  trigger = true;
  NoteShape n = new NoteShape(note);
  if(note.channel()==15){
    bgr+=random(1);
    bgg+=random(1.1,1.7);
    bgb+=random(10,20);
    beat_clock +=1;
    return;
  }
  if(note.channel()==0){
    channel1[bbindex % 4] = n;
    println("channel0");
  }
  if(note.channel()==1){
    channel2[bbindex % 4] = n;
    println("channel1");
  }
  if(note.channel()==2){
    channel3[bbindex % 4] = n;
  }
  if(note.channel()==3){
    channel4[bbindex % 4] = n;
  }

  
  //println();
  //println("Note On:");
  //println("--------");
  //println("Channel:"+note.channel());
  //println("Pitch:"+note.pitch());
  //println("Velocity:"+note.velocity());
}

void noteOff(Note note){
  //println();
  //println("Note Off:");
  //println("--------");
  //println("Channel:"+note.channel());
  //println("Pitch:"+note.pitch());
  //println("Velocity:"+note.velocity());
  ////background(255);
}
class noteInfo {
  public int pitch;
  public int velocity;
}

void trig(){
  if(!trigger){
    noLoop();
  }
  else{
    loop();
  }
}
