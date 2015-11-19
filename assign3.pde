PImage start1, start2, bg1, bg2, fighter, enemy, hp, treasure;
int bg2_x=0;
int treasureWidth=40, treasureHeight=40, treasureX=floor(random(640-treasureWidth)), treasureY=floor(random(40,480-treasureHeight));
int enemyHeight=60,enemyX=-400, enemyY=floor(random(40,480-enemyHeight));
int enemyState=0;

// game state
final int GAME_START=0;
final int GAME_RUN=1;
int gameState=GAME_START;


void setup () {
  size(640, 480);
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  fighter=loadImage("img/fighter.png");
  enemy=loadImage("img/enemy.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png");
}


void draw() {
  switch(gameState){
    case GAME_START:
      image(start2,0,0);
      if(mouseX>210 && mouseX<450 && mouseY>380 && mouseY<410){ // detect mouse location
        image(start1,0,0);
        if(mousePressed){
          gameState=GAME_RUN;
        }
      }
      break;
      
      
    case GAME_RUN:
      // background
      image(bg1,bg2_x-640,0);
      image(bg2,bg2_x,0);
      image(bg2,bg2_x-1280,0);
      bg2_x++;
      bg2_x%=1280;
      
      // hp
      colorMode(RGB);
      fill(255,0,0);
      rect(18,15,200,15);
      image(hp,10,10);
      
      // treasure
      image(treasure,treasureX,treasureY);
      

      // fighter
      image(fighter,580,240);
      
      // enemy
      switch(enemyState){
        case 0:
        for(int i=0;i<5;i++)
          image(enemy,enemyX+i*70,enemyY);
        enemyX+=3;
        break;

        case 1:
        enemyY=constrain(enemyY,160,height-enemyHeight);
        for(int i=0;i<5;i++)
          image(enemy,enemyX+i*70,enemyY-i*40);
          enemyX+=3;
          break;
        
        case 2:
        enemyY=constrain(enemyY,120,height-120-enemyHeight);
        for(int i=0;i<3;i++){
          image(enemy,enemyX+i*70,enemyY-i*60);
          image(enemy,enemyX+(i+2)*70,enemyY-120+i*60);
          image(enemy,enemyX+i*70,enemyY+i*60);
          image(enemy,enemyX+(i+2)*70,enemyY+120-i*60);
        }
        enemyX+=3;
        break;
      }
      
      // change enemyState
      if(enemyX>640){
        enemyX=-400;
        enemyY=floor(random(40,480-enemyHeight));
        enemyState++;
        enemyState%=3;
      }
      break;
  }
}
