PImage bg, title, startNormal, startHovered, restartNormal, restartHovered, gameover, groundhogIdle, groundhogDown, groundhogLeft, groundhogRight, life, soil, soldier, cabbage;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;

//start button
final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

boolean downPressed, rightPressed, leftPressed, idle, right, left;


float soilSize = 80;
float imgSize = 80;
float grassHeight = 15;
float hogSpeed = 80/16;
float hogX;
float hogY;
float sunCenter = 50;
float sunDiameter = 120;
float soldierX = 0;
float soldierY = floor(random(2,6))*soilSize;
float cabbageX = floor(random(8))*soilSize;
float cabbageY = floor(random(2,6))*soilSize;
float frame;

int lifes=2;

void setup() {
	size(640, 480, P2D);
  
  bg=loadImage("img/bg.jpg");
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
  title=loadImage("img/title.jpg");
  gameover=loadImage("img/gameover.jpg");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  life=loadImage("img/life.png");
  soil=loadImage("img/soil.png");
  soldier=loadImage("img/soldier.png");
  cabbage=loadImage("img/cabbage.png");
  
  hogX = soilSize*4;
  hogY = soilSize;
  lifes = 2;
}

void draw() {
	// Switch Game State
  switch(gameState){
    case GAME_START:
      image(title,0,0);
      image(startNormal,248,360);
      //hover
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHovered,248,360);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormal,248,360);
      }
      
    break;
      
    case GAME_RUN:
    
      image(bg,0,0);
      image(soil,0,soilSize*2);
            
      if(lifes==1){
        image(life,10,10);
      }
      if(lifes==2){
        image(life,10,10);
        image(life,80,10);
      }
      if(lifes==3){
        image(life,10,10);
        image(life,80,10);
        image(life,150,10);
      }
      //grass
      noStroke();
      colorMode(RGB);
      fill(124,204,25);
      rectMode(CORNERS);
      rect(0, height/3 - grassHeight, width, height/3);
      //sun
      fill(253,184,19);
      stroke(255,255,0);
      strokeWeight(5);
      ellipse(width-sunCenter, height-(height-sunCenter), sunDiameter, sunDiameter);
      //images
      image(cabbage, cabbageX, cabbageY);
      image(soldier, soldierX, soldierY);
      
      //animation
      soldierX += 4;
      if(soldierX > width){
        soldierX = -80;
      }
      soldierX = soldierX % (width + soilSize);
      
      //hog movement
      if(idle){
        image(groundhogIdle, hogX, hogY);
      }
         idle=true;
      if(right){
        image(groundhogRight, hogX, hogY);
      }
         
      if(left){
        image(groundhogLeft, hogX, hogY);
      }
         left=false; 
         
         
               
      if(downPressed){
        hogY += hogSpeed;
        image(groundhogDown, hogX, hogY);
        idle=false;
      }
        if(hogY + imgSize > height){
          hogY = height - imgSize;
        }  
        if(hogY == soilSize || hogY == soilSize*2 || hogY == soilSize*3 
        || hogY == soilSize*4 || hogY == soilSize*5){
          downPressed=false;
        }
      
                  
     if(leftPressed){
         hogX -= hogSpeed;
         image(groundhogLeft, hogX, hogY);
         idle=false;
        
     }    
        if(hogX <= 0){ 
         leftPressed=false;
         hogX = 0;
         idle=true;
          }
        if(hogX == soilSize || hogX == soilSize*2 || hogX == soilSize*3 
        || hogX == soilSize*4 || hogX == soilSize*5 || hogX == soilSize*6){
          leftPressed=false;
          
        }
           
           
     if(rightPressed){
         hogX += hogSpeed;
         image(groundhogRight, hogX, hogY);
         idle=false;
     }
          if(hogX + imgSize > width) {
           hogX = width - imgSize;
           rightPressed=false;
           idle=true;
           right=false;
         }
         
         if(hogX == soilSize || hogX == soilSize*2 || hogX == soilSize*3 
         || hogX == soilSize*4 || hogX == soilSize*5 || hogX == soilSize*6){ 
           rightPressed=false; 
         }
     
        
     //hog and soldier
     if((hogX+imgSize)>(soldierX+=4)&&(hogX)<((soldierX+=4)+imgSize)
     &&(hogY)<(soldierY+imgSize)&&(hogY+imgSize)>(soldierY)){
       hogX=soilSize*4;
       hogY=soilSize;
       leftPressed=false;
       rightPressed=false;
       lifes--;
       if(lifes==0){
       gameState = GAME_OVER;
       }  
     }
                       
     //hog and cabbage
     if((hogX+imgSize)>(cabbageX)&&(hogX)<(cabbageX+imgSize)
     &&(hogY)<(cabbageY+imgSize)&&(hogY+imgSize)>(cabbageY)){
       cabbageX=-100;
       cabbageY=-100;
       lifes++; 
     }
   break;
     
   
    
  	case GAME_OVER:
      image(gameover,0,0);
      image(restartNormal,248,360);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHovered, 248,360);
        if(mousePressed){
          lifes=2;
          gameState = GAME_RUN;
          cabbageX = floor(random(8))*soilSize;
          cabbageY = floor(random(2,6))*soilSize;
          soldierY = floor(random(2,6))*soilSize;
        }
        }else{
        image(restartNormal, 248,360);
        }

    break;	

		}
	}


void keyPressed(){
  switch(keyCode){
    case DOWN:
    downPressed = true;
    break;
    case RIGHT:
    rightPressed = true;
    break;
    case LEFT:
    leftPressed = true;
    break;
  }
}
