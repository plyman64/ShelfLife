
class Player {
 
  int x, y; //The x and y coordinates of the player
  int r; //The radius of the player
  int vel; //The speed at which the player moves
  boolean isUp, isRight, isDown, isLeft;
  boolean sprinting;
  color playerColor;
  
  Player() {
   
    x = width/2;
    y = height/2;
    r = 10;
    vel = 2;
    sprinting = false;
    playerColor = color(255, 0, 0);
    
  }
  
  void draw() {
   
    fill(playerColor);
    ellipse(x, y, 2*r, 2*r);
    
  }
  
  void drawToolbar() {
    
  }
  
  void move() {
    x = constrain(x + vel*(int(isRight) - int(isLeft)), r, width  - r);
    y = constrain(y + vel*(int(isDown)  - int(isUp)),   r, height - r);
  }
  
  boolean setMove(int k, boolean b) {
    switch (k) {
    case 'W':
    case UP:
      return isUp = b;
 
    case 'S':
    case DOWN:
      return isDown = b;
 
    case 'A':
    case LEFT:
      return isLeft = b;
 
    case 'D':
    case RIGHT:
      return isRight = b;
 
    default:
      return b;
    }
  }
}
