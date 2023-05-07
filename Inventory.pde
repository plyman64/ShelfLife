
class Inventory {
 
  ItemGroup selectedItem;
  CraftingRecipe selectedRecipe;
  ArrayList <ItemGroup> itemTypesIn;
  boolean crafting;
  
  int invRadX = 225;
  int invRadY = 275;
  int invX = (512) - invRadX;
  int invY = (320) - invRadY;
  int textSize = 20;
  
  int tabH = textSize + 5;
  int tabW = (2 * invRadX) / 3;
  
  Button craftBtn = new Button(invX + (2 * invRadX) + 125, invY + 400, 100, 35, 0, 0, 0, "Craft");
  
  Inventory() {
   
    selectedItem = null;
    itemTypesIn = new ArrayList <ItemGroup> ();
    crafting = false;
    
    invRadX = 225;
    invRadY = 250;
    invX = (512) - invRadX;
    invY = (320) - invRadY;
    textSize = 20;
    tabH = textSize + 10;
    tabW = (2 * invRadX) / 3;
    
  }
  
  void draw() {
    textSize(textSize);
    //If crafting, draw crafting perspective
    if(crafting) {
      drawCraftingPerspective();
    //Otherwise, draw inventory perspecive
    } else {
      drawInvPerspective();
    }
  }
  
  void drawInvPerspective() {
    textAlign(LEFT, CENTER);
    stroke(0);
    strokeWeight(2);
    fill(175);
    //Main box
    rect(invX, invY, 2 * invRadX, 2 * invRadY, 0, 10, 10, 10);
    
    //Tabs
    rect(invX, invY - tabH, tabW, tabH, 10, 10, 0, 0);
    rect(invX + tabW, invY - tabH, tabW, tabH, 10, 10, 0, 0);
    
    //Erase line under "Inventory" tab
    stroke(175);
    strokeWeight(3);
    line(invX + 3, invY, invX + tabW - 3, invY);
    
    //rect(invX + 2, invY, tabW - 20, 2);
    fill(255);
    text("Inventory", invX + 30, invY - (tabH / 2) - 3);
    fill(100);
    text("Crafting", invX + tabW + 37, invY - (tabH / 2) - 3);
    
    //If inventory is empty
    if(itemTypesIn.isEmpty()) {
      fill(0);
      text("There isn't anything here . . .", invX + 85, invY + 40);
    } else {
      drawItemList();
      drawSelectedItemDetails();
      //Draw "Drop" button
      
    }
  }
  
  void drawItemList() {
    int textX = invX + 30, textY = invY + 30;
    
    textSize(textSize);
    
    //For each item type in inventory
    for(int i = 0; i < itemTypesIn.size(); i++) {
      ItemGroup itemType = itemTypesIn.get(i);
      //If the item type is the selected item type or another item type that is being hovered over by the cursor, set fill to 255
      if((mouseX > textX && mouseX < textX + 160 && mouseY >= textY - textSize/2 + 5 && mouseY <= textY + textSize/2 + 1) || itemType == selectedItem){
        fill(255);
      //Otherwise, set fill to 100
      } else {
        fill(100);
      }
      //Write the name of the item in the inventory
      text(itemType.name, textX, textY);
      //Write number of items in inventory
      text("x" + itemType.numInInv, textX + 135, textY);
      textY += textSize + 5;
    }
  }
  
  void drawSelectedItemDetails() {
    textSize(15);
    
    //For selected item
    if(selectedItem != null) {
      //Draw item box
      noFill();
      stroke(0);
      rect(505, 95, 200, 200, 10);
      
      //Draw image
      image(selectedItem.invImg, 510, 95);
      
      //Write item description
      fill(0);
      textAlign(CENTER, TOP);
      text(selectedItem.description, 505, 310, 200, 200);
    }
  }
  
    void drawCraftingPerspective() {
    textAlign(LEFT, CENTER);
    stroke(0);
    strokeWeight(2);
    fill(175);
    //Main box
    rect(invX, invY, 2 * invRadX, 2 * invRadY, 0, 10, 10, 10);
    
    //Tabs
    rect(invX, invY - tabH, tabW, tabH, 10, 10, 0, 0);
    rect(invX + tabW, invY - tabH, tabW, tabH, 10, 10, 0, 0);
    
    //Erase line under "Crafting" tab
    stroke(175);
    strokeWeight(3);
    line(invX + tabW + 3, invY, invX + (2 * tabW) - 3, invY);
    fill(100);
    text("Inventory", invX + 30, invY - (tabH / 2) - 3);
    fill(255);
    text("Crafting", invX + tabW + 37, invY - (tabH / 2) - 3);
    
    drawCraftingItemList();
    drawCraftingItemDetails();
    if(selectedRecipe != null) {
      drawCraftingButton();
    }
  }
  
  void drawCraftingItemList() {
    int textX = invX + 30, textY = invY + 30;
    
    //For each crafting recipe in craftingRecipes
    for(int i = 0; i <= numItemTypes - 1; i++) {
      CraftingRecipe recipe = craftingRecipes.get(i);
      if(recipe != null && recipe.isUnlocked()) {
        //If the recipe is selected or the cursor is over the name of the recipe
        if((mouseX > textX && mouseX < textX + 160 && mouseY >= textY - textSize/2 + 5 && mouseY <= textY + textSize/2 + 1) || recipe == selectedRecipe){
          //Set fill to 255
          fill(255);
        //Else, set fill to 100
        } else {
          fill(100); 
        }
        //Write name of recipe
        text(recipe.name, textX, textY);
        textY += textSize + 5;
      }
    }
  }
  
  void drawCraftingItemDetails() {
    
    if(selectedRecipe != null) {
      textSize(15);
      int textX = invX + (2 * invRadX) + 60;
      int textY = invY + 115;
      int imgX = textX - 40;
      int imgY = textY - 13;
      
      noFill();
      stroke(0);
      //Box that shows the image of the selected recipe's product
      rect(505, 95, 200, 200, 10);
      
      //Write description of item
      fill(0);
      textAlign(CENTER, TOP);
      text(woodPlank.description, 505, 310, 200, 200);
      
      //Draw image
      image(selectedRecipe.product.invImg, 510, 95);
      
      //Box that contains the ingredient list and crafting button
      fill(175);
      rect(invX + (2 * invRadX), invY + 50, 250, (2 * invRadY) - 100, 0, 10, 10, 0);
      
      //Draw ingredients list
      fill(0);
      textSize(20);
      textAlign(CENTER, CENTER);
      text("Materials Required", invX + (2 * invRadX) + 125, invY + 75);
      //For each ingredient
      textSize(15);
      textAlign(LEFT, CENTER);
      
      image(selectedRecipe.item1.groundImg, imgX, imgY);
      text(selectedRecipe.item1.name, textX, textY);
      text("x" + selectedRecipe.numItem1, textX + 135, textY);
      textY += 20;
      text("You have: " + selectedRecipe.item1.numInInv, textX, textY);
      if(selectedRecipe.item1.numInInv >= selectedRecipe.numItem1) {
        image(greenCheck, imgX + 195, imgY - 3);
      } else {
        image(redX, imgX + 200, imgY + 5);
      }
      
      textY += 50;
      
      if(selectedRecipe.item2 != null) {
        image(selectedRecipe.item2.groundImg, imgX, imgY);
        text(selectedRecipe.item2.name, textX, textY);
        text("x" + selectedRecipe.numItem2, textX + 135, textY);
        textY += 20;
        text("You have: " + selectedRecipe.item2.numInInv, textX, textY);
        if(selectedRecipe.item2.numInInv >= selectedRecipe.numItem2) {
          image(greenCheck, imgX + 195, imgY - 3);
        } else {
          image(redX, imgX + 200, imgY + 5);
        }
      }
      
      textY += 50;
      
      if(selectedRecipe.item3 != null) {
        image(selectedRecipe.item3.groundImg, imgX, imgY);
        text(selectedRecipe.item3.name, textX, textY);
        text("x" + selectedRecipe.numItem3, textX + 135, textY);
        textY += 20;
        text("You have: " + selectedRecipe.item3.numInInv, textX, textY);
        if(selectedRecipe.item3.numInInv >= selectedRecipe.numItem3) {
          image(greenCheck, imgX + 195, imgY - 3);
        } else {
          image(redX, imgX + 200, imgY + 5);
        }
      }
    }
  }
  
  void drawCraftingButton() {
    craftBtn.active = true;
    
    if(!selectedRecipe.product.canCraft()) {
      craftBtn.active = false;
    }
    
    craftBtn.draw();
  }
  
  /*
  ItemGroup getHoveredItem(ItemGroup itemType) {
    ItemGroup hoveredItem = null; 
    //itemIDsIn = sort(itemIDsIn);
    
    //If there is at least 1 item of itemType in the inventory
    if(itemType.numInInv > 0) {
      //If the cursor is within a certain range of the item name
      
      if((mouseX > invX + 15) &&
          mouseX < invX + (textSize * itemType.name.length()) &&
          mouseY > invY + ((textSize + 5) * (getIndexOf(itemType.ID))) &&
          mouseY < invY + ((textSize + 5) * (getIndexOf(itemType.ID)) + textSize)) {
          
        //Set itemType to that item
        hoveredItem = itemType;
      }
    }
    return hoveredItem;
  }
  */
  
  int getIndexOf(int ID) {
    int index = 0;
    //For each element in itemTypesIn
    for(int i = 0; i < itemTypesIn.size(); i++) {
      //If the element in that position is the ID being searched for
      if(itemTypesIn.get(i) == itemTypes[ID]) {
        //Set index to that index
        index = i;
        break;
      }
    }
    return index;
  }
  
  void setSelectedItem(ItemGroup itemType) {
    selectedItem = itemType;
  }
  
  void setSelectedRecipe(CraftingRecipe recipe) {
    selectedRecipe = recipe; 
  }
  
  void processInventoryClick() {
    //If cursor is over one of the tabs
    if(mouseY > invY - tabH && mouseY < invY) {
      //If cursor is over "Crafting" tab
      if(mouseX > invX + tabW && mouseX < invX + (2 * tabW)) {
        //Set crafting to true
        crafting = true;
        //Else if cursor is over "Inventory" tab
      } else {
        //Set crafting to false
        crafting = false;
      }
    }
    
    //If the player is viewing the crafting interface
    if(crafting) {
      //If the cursor is over one of the recipes on the list, select it
      if(mouseX > 305 && mouseX < 465) {
        if(mouseY > 95 && mouseY < 95 + (numItemTypes * 25)) {
          //println("Recipe list clicked.");
          for(int i = 0; i < knownRecipes.size(); i++) {
            if(mouseY > 95 + (25 * i) - 1 && mouseY < 95 + (25 * (i + 1)) - 9) {
              //println("Recipe clicked: " + knownRecipes.get(i));
              //println("Recipe index: " + i);
              setSelectedRecipe(knownRecipes.get(i));
              //println(selectedRecipe.name);
            }
          }
        }
      }
      //If the cursor is over the "craft" button, craft the item
      if(craftBtn.hovered()) {
        selectedRecipe.product.craft(); 
      }
      
    //Else, if the player is viewing their inventory
    } else {
      //If the cursor is over one of the items on the list, select it
      if(mouseX > 305 && mouseX < 465) {
        if(mouseY > 95 && mouseY < 95 + (itemTypesIn.size() * 25)) {
          for(int i = 0; i < itemTypesIn.size(); i++) {
            if(mouseY > 95 + (25 * i) - 1 && mouseY < 95 + (25 * (i + 1)) - 9) {
              setSelectedItem(itemTypesIn.get(i));
            }
          }
        }
      //Else, if the cursor is over the "drop" button, drop the item
      }
    }
  }
}
