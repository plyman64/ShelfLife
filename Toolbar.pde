
class Toolbar {
  
  int w, h;
  int x, y;
  ArrayList <ItemGroup> itemTypesIn;
  
  int boxX, boxY;
  int boxW, boxH;
 
  Toolbar() {
    w = 512;
    h = 74;
    x = 512 - w/2;
    y = 640 - h;
    
    boxW = 48;
    boxH = 48;
    boxX = x + 14;
    boxY = y + 14;
  }
  
  void draw() {
    drawOutline();
    drawBoxes();
    drawBoxContents();
  }
  
  void drawOutline() {
    fill(175);
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h, 10, 10, 0, 0);
  }
  
  void drawBoxes() {
    boxX = x + 14;
    
    for(int i = 1; i <= 8; i++) {
      fill(100);
      noStroke();
      rect(boxX, boxY, boxW, boxH, 5);
      //For the box that is selected, highlight it
      
      boxX += (boxW + 14);
    }
  }
  
  void drawBoxContents() {
    //Draw item images in boxes
    
    //Draw number of item in lower left corner
    
  }
  
}
