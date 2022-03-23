
int T = 0;
int R = 1;
int B = 2;
int L = 3;

class ItemGroup {
  
  PImage invImg;
  PImage groundImg;
  String name;
  String description;
  int ID;
  int stackSize;
  int durability;
  
  int numInInv;
  int numOnToolbar;
  int itemsCreated;
  
  //A collection of coordinates for each item of the ItemGroup's type that is on the ground
  HashMap <Integer, int []> itemsOnGround;
  
  //For items that have a durability
  ItemGroup(PImage tempInvImg, PImage tempGroundImg, String tempName, String tempDescription, int tempID, int tempStackSize, int tempDurability) {
    
    numInInv = 0;
    numOnToolbar = 0;
    itemsCreated = 0;
    
    invImg = tempInvImg;
    groundImg = tempGroundImg;
    name = tempName;
    description = tempDescription;
    ID = tempID;
    stackSize = tempStackSize;
    durability = tempDurability;
     
    itemsOnGround = new HashMap <Integer, int []> ();
     
  }
   
  //For items that don't have a durability
  ItemGroup(PImage tempInvImg, PImage tempGroundImg, String tempName, String tempDescription, int tempID, int tempStackSize) {
    
    numInInv = 0;
    numOnToolbar = 0;
    itemsCreated = 0;
    
    invImg = tempInvImg;
    groundImg = tempGroundImg;
    name = tempName;
    description = tempDescription;
    ID = tempID;
    stackSize = tempStackSize;
    
    itemsOnGround = new HashMap <Integer, int []> ();
     
  }
   
  void drawOnGround(int index) {
    image(groundImg, itemsOnGround.get(index)[0], itemsOnGround.get(index)[1]);
  }
  
  void washUp() {
    //println("washUp() called");
    
    //Pick a random spot to appear on the shore
    //Choose top, bottom, left, or right of screen
    int side = (int) random(0, 4);
     
    int x = y = 0;
    //Then choose where on that side the item will appear
    if(side == T) {
      x = (int) random(80, 913);
      y = 48;
    } else if(side == R) {
      x = 912;
      y = (int) random(48, 497);
    } else if(side == B) {
      x = (int) random(80, 913);
      y = 498;
    } else if(side == L) {
      x = 80;
      y = (int) random(48, 497);
    }
     
    //Put the item and its coordinates into the HashMap of coordinates
    itemsOnGround.put(itemsCreated++, new int [] {x, y});
  }
 
   void pickUp(int index) {
     //If inventory doesn't have room for this item
     //return;
    
    //This item no longer has coordinates. Get rid of the respective key, value pair
    itemsOnGround.remove(index);
    
    //If an item of this type isn't already in inventory
    if(numInInv++ == 0) { //Also, increment the number of this item type that is in inventory
      //Add it to the ArrayList
      inventory.itemTypesIn.add(itemTypes[ID]); 
    }
  }
  
  boolean isTouchingPlayer(int index, Player player) {
    //If the player is within (16 + r) pixels of the item
    if((16 + player.r) > dist(player.x, player.y, itemsOnGround.get(index)[0], itemsOnGround.get(index)[1])) {
      return true;
    }
    return false; 
  }
  
  void drop() {
    
  }
  
  boolean canCraft() {
    boolean b1 = true;
    boolean b2 = true;
    boolean b3 = true;
    
    CraftingRecipe recipe = craftingRecipes.get(ID);
    if(recipe.item1.numInInv < recipe.numItem1) {
      b1 = false;
    }
    
    if(recipe.item2 != null) {
      //println("Item 2 is not null");
      if(recipe.item2.numInInv < recipe.numItem2) {
        b2 = false;
      }
    }
    
    if(recipe.item3 != null) {
      //println("Item 3 is not null");
      if(recipe.item3.numInInv < recipe.numItem3) {
        b3 = false;
      }
    }
    
    return b1 && b2 && b3; 
  }
   
  void craft() {
    CraftingRecipe recipe = craftingRecipes.get(ID);
    
    //If in survival mode
    if(GAMEMODE == SURVIVAL) {
      //Remove items used to craft from inventory
      recipe.item1.numInInv -= recipe.numItem1;
      if(recipe.item1.numInInv == 0) {
        inventory.itemTypesIn.remove(recipe.item1); 
      }
      
      if(recipe.item2 != null) {
        recipe.item2.numInInv -= recipe.numItem1;
          if(recipe.item2.numInInv == 0) {
          inventory.itemTypesIn.remove(recipe.item2); 
        }
      }
      
      if(recipe.item3 != null) {
        recipe.item3.numInInv -= recipe.numItem1;
          if(recipe.item3.numInInv == 0) {
          inventory.itemTypesIn.remove(recipe.item3); 
        }
      }
    }
    //Add crafted item to inventory
    if(!inventory.itemTypesIn.contains(itemTypes[ID])) {
      inventory.itemTypesIn.add(itemTypes[ID]);
    }
    numInInv += recipe.numProduct;
  }
   
  void reduceDurability() {
    durability -= 1;
      if(durability == 0) {
      //The item breaks, remove it from inventory
       
      }
   }
}
