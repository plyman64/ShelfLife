
class Button {
  
 int x, y, w, h, r, g, b;
 String text;
 boolean active;
 
 Button() {
   
   active = true;
   
   x = 0;
   y = 0;
   w = 100;
   h = 50;
   r = 0;
   g = 0;
   b = 0;
   text = "null";
   
 }
 
 Button(int tempX, int tempY, int tempW, int tempH, int tempR, int tempG, int tempB, String tempText) {
   
   active = true;
   
   x = tempX;
   y = tempY;
   w = tempW;
   h = tempH;
   r = tempR;
   g = tempG;
   b = tempB;
   text = tempText;
   
 }
 
 void draw() {
  
  int newR = r;
  int newG = g;
  int newB = b;
  
  if(hovered()) {
    newR += 100;
    newG += 100;
    newB += 100;
  }
  
  if(!active) {
    newR = 175;
    newG = 175;
    newB = 175;
  }
  
  if(newR > 255) {
    newR = 255;
  }
  if(newG > 255) {
    newG = 255;
  }
  if(newB > 255) {
    newB = 255;
  }
  
  fill(newR, newG, newB);
  rect(x - w/2, y, w, h);
  //if(r > 127 && g > 127 && b > 127) {
  if(active) {
    fill(255);
  } else {
    fill(100);
  }
  
  textSize(4 * (h / 5));
  textAlign(CENTER, CENTER);
  text(text, x, y + 3 * (h / 7));
   
 }
 
 boolean hovered() {
   if(!active) {
     return false; 
   }
   
   if(mouseX > x - w/2 &&
      mouseX < x + w/2 &&
      mouseY > y &&
      mouseY < y + h) {
   
      return true;
   
   } else {
   
     return false;
   
   }
   
 }
 
 boolean isPressed() {
   
   if(mouseX > x &&
      mouseX < x + w &&
      mouseY > y &&
      mouseY < y + h) {
   
      return true;
   
   } else {
   
     return false;
   
   }
  
  }

}
