
int screen = 0;
int m, r;
int washUpTimer;
int timeUntilWashUp;
int SURVIVAL = 0;
int CREATIVE = 1;
int GAMEMODE = SURVIVAL;
boolean showInv = false;
Button newGameBtn;
PImage grassTileImg, sandTileImg, waterTileImg;
PImage greenCheck, redX;

Player player;
Toolbar toolbar;
Inventory inventory;

//ItemGroups
ItemGroup driftwood, stick, scrapPlastic, scrapGlass, shell, bone; //Common washUp() items, 60% chance
ItemGroup plasticBottle, glassBottle, ductTape, woodPlank; //Uncommon washUp() items, 30% chance
ItemGroup copperWire, fishingLine; //Rare washUp() items, 10% chance

ItemGroup plasticWaterBottle, glassWaterBottle, workbench; //Other items
ItemGroup ironOre, copperOre, coal, dirt, sand, stone; //Mineables
ItemGroup rock, charcoal; //Other materials
ItemGroup fertilizer, oakSeed, palmSeed, coconut, hoe; //Farming

ItemGroup woodFishingPole, woodAxe, woodShovel, woodPickaxe; //Wood tools
ItemGroup stoneAxe, stoneShovel, stonePickaxe; //Stone tools
ItemGroup ironAxe, ironShovel, ironPickaxe; //Iron tools

//Item IDs
int currentID = 0;

//CommonWashUpItems
int DRIFTWOOD = currentID++;
int STICK = currentID++;
int SCRAPPLASTIC = currentID++;
int SCRAPGLASS = currentID++;
int SHELL = currentID++;
int BONE = currentID++;

//UncommonWashUpItems
int PLASTICBOTTLE = currentID++;
int GLASSBOTTLE = currentID++;
int DUCTTAPE = currentID++;
int WOODPLANK = currentID++; 

//RareWashUpItems
int COPPERWIRE = currentID++;
int FISHINGLINE = currentID++;

//Other Items
int PLASTICWATERBOTTLE = currentID++;
int GLASSWATERBOTTLE = currentID++;
int WORKBENCH = currentID++;

/*
//Mineables
int IRONORE = currentID++;
int COPPERORE = currentID++;
int COAL = currentID++;
int DIRT = currentID++;
int SAND = currentID++;
int STONE = currentID++;

//Other materials
int ROCK = currentID++;
int CHARCOAL = currentID++;

//Farming
int FERTILIZER = currentID++;
int OAKSEED = currentID++;
int PALMSEED = currentID++;
int COCONUT = currentID++;
int HOE = currentID++;

//Wood tools
int WOODFISHINGPOLE = currentID++;
int WOODAXE = currentID++;
int WOODSHOVEL = currentID++;
int WOODPICKAXE = currentID++;

//Stone tools
int STONEAXE = currentID++;
int STONESHOVEL = currentID++;
int STONEPICKAXE = currentID++;

//Iron tools
int IRONAXE = currentID++;
int IRONSHOVEL = currentID++;
int IRONPICKAXE = currentID++;
*/

int numItemTypes = currentID;

ItemGroup [] itemTypes = new ItemGroup [numItemTypes];

//Item images
PImage driftwoodGroundImg, stickGroundImg, scrapPlasticGroundImg, scrapGlassGroundImg, shellGroundImg, boneGroundImg;
PImage driftwoodInvImg, stickInvImg, scrapPlasticInvImg, scrapGlassInvImg, shellInvImg, boneInvImg;
PImage plasticBottleGroundImg, glassBottleGroundImg, ductTapeGroundImg, woodPlankGroundImg;
PImage plasticBottleInvImg, glassBottleInvImg, ductTapeInvImg, woodPlankInvImg;
PImage copperWireGroundImg, fishingLineGroundImg;
PImage copperWireInvImg, fishingLineInvImg;
PImage plasticWaterBottleGroundImg, glassWaterBottleGroundImg, workbenchGroundImg;
PImage plasticWaterBottleInvImg, glassWaterBottleInvImg, workbenchInvImg;
PImage ironOreGroundImg, copperOreGroundImg, coalGroundImg, dirtGroundImg, sandGroundImg, stoneGroundImg;
PImage ironOreInvImg, copperOreInvImg, coalInvImg, dirtInvImg, sandInvImg, stoneInvImg;
PImage rockGroundImg, charcoalGroundImg;
PImage rockInvImg, charcoalInvImg;
PImage fertilizerGroundImg, oakSeedGroundImg, palmSeedGroundImg, coconutGroundImg, hoeGroundImg;
PImage fertilizerInvImg, oakSeedInvImg, palmSeedInvImg, coconutInvImg, hoeInvImg;
PImage woodFishingPoleGroundImg, woodAxeGroundImg, woodShovelGroundImg, woodPickaxeGroundImg;
PImage woodFishingPoleInvImg, woodAxeInvImg, woodShovelInvImg, woodPickaxeInvImg;
PImage stoneAxeGroundImg, stoneShovelGroundImg, stonePickaxeGroundImg;
PImage stoneAxeInvImg, stoneShovelInvImg, stonePickaxeInvImg;
PImage ironAxeGroundImg, ironShovelGroundImg, ironPickaxeGroundImg;
PImage ironAxeInvImg, ironShovelInvImg, ironPickaxeInvImg;

//Crafting Recipes
CraftingRecipe woodPlankRecipe;
CraftingRecipe stickRecipe;
CraftingRecipe scrapPlasticRecipe;
CraftingRecipe scrapGlassRecipe;
CraftingRecipe workbenchRecipe;

HashMap <Integer, CraftingRecipe> craftingRecipes;
int numCraftingRecipes;

ArrayList <CraftingRecipe> knownRecipes;

//Blocks
BlockGroup workbenchBlock;

HashMap <Integer, BlockGroup> blocks;
int numBlockTypes;

void setup() {
  size(1024, 640); //8 Tiles by 5 Tiles
  textAlign(CENTER, CENTER);
  strokeWeight(3);
  
  grassTileImg = loadImage("grassTile.png");
  grassTileImg.loadPixels();
  grassTileImg.resize(32, 32);
  grassTileImg.updatePixels();
  
  sandTileImg = loadImage("sandTile.jpg");
  sandTileImg.loadPixels();
  sandTileImg.resize(32, 32);
  sandTileImg.updatePixels();
  
  waterTileImg = loadImage("waterTile.jpg");
  waterTileImg.loadPixels();
  waterTileImg.resize(32, 32);
  waterTileImg.updatePixels();
  
  greenCheck = loadImage("greenCheck.png");
  greenCheck.loadPixels();
  greenCheck.resize(32, 32);
  greenCheck.updatePixels();
  
  redX = loadImage("redX.png");
  redX.loadPixels();
  redX.resize(20, 20);
  redX.updatePixels();
  
  driftwoodInvImg = loadImage("driftwoodInv.png");
  driftwoodInvImg.loadPixels();
  driftwoodInvImg.resize(192, 192);
  driftwoodInvImg.updatePixels();
  driftwoodGroundImg = loadImage("driftwoodGround.png");
  
  stickInvImg = loadImage("stickInv.png");
  stickInvImg.loadPixels();
  stickInvImg.resize(192, 192);
  stickInvImg.updatePixels();
  stickGroundImg = loadImage("stickGround.png");
  
  scrapPlasticInvImg = loadImage("scrapPlasticInv.png");
  scrapPlasticInvImg.loadPixels();
  scrapPlasticInvImg.resize(192, 192);
  scrapPlasticInvImg.updatePixels();
  scrapPlasticGroundImg = loadImage("scrapPlasticGround.png");
  
  scrapGlassInvImg = loadImage("scrapGlassInv.png");
  scrapGlassInvImg.loadPixels();
  scrapGlassInvImg.resize(192, 192);
  scrapGlassInvImg.updatePixels();
  scrapGlassGroundImg = loadImage("scrapGlassGround.png");
  
  shellInvImg = loadImage("shellInv.png");
  shellInvImg.loadPixels();
  shellInvImg.resize(192, 192);
  shellInvImg.updatePixels();
  shellGroundImg = loadImage("shellGround.png");
  
  boneInvImg = loadImage("boneInv.png");
  boneInvImg.loadPixels();
  boneInvImg.resize(192, 192);
  boneInvImg.updatePixels();
  boneGroundImg = loadImage("boneGround.png");
  
  plasticBottleInvImg = loadImage("plasticBottleInv.png");
  plasticBottleInvImg.loadPixels();
  plasticBottleInvImg.resize(192, 192);
  plasticBottleInvImg.updatePixels();
  plasticBottleGroundImg = loadImage("plasticBottleGround.png");
  
  glassBottleInvImg = loadImage("glassBottleInv.png");
  glassBottleInvImg.loadPixels();
  glassBottleInvImg.resize(192, 192);
  glassBottleInvImg.updatePixels();
  glassBottleGroundImg = loadImage("glassBottleGround.png");
  
  ductTapeInvImg = loadImage("ductTapeInv.png");
  ductTapeInvImg.loadPixels();
  ductTapeInvImg.resize(192, 192);
  ductTapeInvImg.updatePixels();
  ductTapeGroundImg = loadImage("ductTapeGround.png");
  
  woodPlankInvImg = loadImage("woodPlankInv.png");
  woodPlankInvImg.loadPixels();
  woodPlankInvImg.resize(192, 192);
  woodPlankInvImg.updatePixels();
  woodPlankGroundImg = loadImage("woodPlankGround.png");
  
  copperWireInvImg = loadImage("copperWireInv.png");
  copperWireInvImg.loadPixels();
  copperWireInvImg.resize(192, 192);
  copperWireInvImg.updatePixels();
  copperWireGroundImg = loadImage("copperWireGround.png");
  
  fishingLineInvImg = loadImage("fishingLineInv.png");
  fishingLineInvImg.loadPixels();
  fishingLineInvImg.resize(192, 192);
  fishingLineInvImg.updatePixels();
  fishingLineGroundImg = loadImage("fishingLineGround.png");
  
  plasticWaterBottleInvImg = loadImage("plasticWaterBottleInv.png");
  plasticWaterBottleInvImg.loadPixels();
  plasticWaterBottleInvImg.resize(192, 192);
  plasticWaterBottleInvImg.updatePixels();
  plasticWaterBottleGroundImg = loadImage("plasticWaterBottleGround.png");
  
  glassWaterBottleInvImg = loadImage("glassWaterBottleInv.png");
  glassWaterBottleInvImg.loadPixels();
  glassWaterBottleInvImg.resize(192, 192);
  glassWaterBottleInvImg.updatePixels();
  glassWaterBottleGroundImg = loadImage("glassWaterBottleGround.png");
  
  workbenchInvImg = loadImage("workbenchInv.png");
  workbenchInvImg.loadPixels();
  workbenchInvImg.resize(192, 192);
  workbenchInvImg.updatePixels();
  workbenchGroundImg = loadImage("workbenchGround.png");
  
  r = 0; //To control the flashing "Click to Start" text on the first screen
  newGameBtn = new Button(width/2, 250, 225, 50, 0, 0, 0, "New Game");
  
  //Instantiate ItemGroups
  driftwood = new ItemGroup(driftwoodInvImg, driftwoodGroundImg, "Driftwood", "A piece of old wood that washed up on the beach. Can be made into wood planks.", DRIFTWOOD, 100);
  stick = new ItemGroup(stickInvImg, stickGroundImg, "Stick", "A small, thin piece of wood.", STICK, 100);
  scrapPlastic = new ItemGroup(scrapPlasticInvImg, scrapPlasticGroundImg, "Scrap Plastic", "Some junky, old plastic.", SCRAPPLASTIC, 100);
  scrapGlass = new ItemGroup(scrapGlassInvImg, scrapGlassGroundImg, "Scrap Glass", "Some broken glass.", SCRAPGLASS, 100);
  shell = new ItemGroup(shellInvImg, shellGroundImg, "Shell", "A shell from the ocean.", SHELL, 100);
  bone = new ItemGroup(boneInvImg, boneGroundImg, "Bone", "A bone from a once-living creature.", BONE, 100);
  plasticBottle = new ItemGroup(plasticBottleInvImg, plasticBottleGroundImg, "Plastic Bottle", "A bottle made of plastic. Can be scrapped for scrap plastic or used to hold liquids.", PLASTICBOTTLE, 100);
  glassBottle = new ItemGroup(glassBottleInvImg, glassBottleGroundImg, "Glass Bottle", "A bottle made of glass. Can be scrapped for scrap glass or used to hold liquids.", GLASSBOTTLE, 100);
  ductTape = new ItemGroup(ductTapeInvImg, ductTapeGroundImg, "Duct Tape", "A roll of strong tape.", DUCTTAPE, 100);
  woodPlank = new ItemGroup(woodPlankInvImg, woodPlankGroundImg, "Wood Plank", "A long, flat piece of wood.", WOODPLANK, 100);
  copperWire = new ItemGroup(copperWireInvImg, copperWireGroundImg, "Copper Wire", "A piece of copper wire.", COPPERWIRE, 100);
  fishingLine = new ItemGroup(fishingLineInvImg, fishingLineGroundImg, "Fishing Line", "A piece of fishing line.", FISHINGLINE, 100);
  plasticWaterBottle = new ItemGroup(plasticWaterBottleInvImg, plasticWaterBottleGroundImg, "Plastic Water Bottle", "A plastic bottle filled with water.", PLASTICWATERBOTTLE, 100);
  glassWaterBottle = new ItemGroup(glassWaterBottleInvImg, glassWaterBottleGroundImg, "Glass Water Bottle", "A glass bottle filled with water.", GLASSWATERBOTTLE, 100);
  workbench = new ItemGroup(workbenchInvImg, workbenchGroundImg, "Workbench", "A wooden bench used to craft more complex items.", WORKBENCH, 100);
  
  /*
  ironOre = new ItemGroup(ironOreInvImg, ironOreGroundImg, "Iron Ore", "A chunk of iron ore. Can be smelted in a forge.", 100);
  copperOre = new ItemGroup(copperOreInvImg, copperOreGroundImg, "Copper Ore", "A chunk of copper ore. Can be smelted in a forge.", 100);
  coal = new ItemGroup(coalInvImg, coalGroundImg, "Coal", "A chunk of coal. Can be used as fuel or for crafting.", 100);
  dirt = new ItemGroup(dirtInvImg, dirtGroundImg, "Dirt", "Hey look, they put you in the game!", 100);
  sand = new ItemGroup(sandInvImg, sandGroundImg, "Sand", "I don't like sand. It's coarse and rough and irritating and it gets everywhere.", 100);
  stone = new ItemGroup(stoneInvImg, stoneGroundImg, "Stone", "Some crushed rocks. A good crafting material.", 100);
  rock = new ItemGroup(rockInvImg, rockGroundImg, "Rock", "It's a rock.", 100);
  charcoal = new ItemGroup(charcoalInvImg, charcoalGroundImg, "Charcoal", "Charred wood. It's kinda like coal.", 100);
  fertilizer = new ItemGroup(fertilizerInvImg, fertilizerGroundImg, "Fertilizer", "Good for helping plants grow a bit faster.", 100);
  oakSeed = new ItemGroup(oakSeedInvImg, oakSeedGroundImg, "Oak Seed", "An acorn, really. If planted, it will become a mighty oak tree . . . eventually.", 100);
  palmSeed = new ItemGroup(palmSeedInvImg, palmSeedGroundImg, "Palm Seed", "When planted, this will yield a plam tree, possibly with coconuts.", 100);
  coconut = new ItemGroup(coconutInvImg, coconutGroundImg, "Coconut", "You'll need something strong to crack this, but it will be worth the effort.", 100);
  hoe = new ItemGroup(hoeInvImg, hoeGroundImg, "Hoe", "A tool used for tilling soil.", 1);
  woodFishingPole = new ItemGroup(woodFishingPoleInvImg, woodFishingPoleGroundImg, "Wood Fishing Pole", "A crude fishing pole crafted from wood and string.", 1);
  woodAxe = new ItemGroup(woodAxeInvImg, woodAxeGroundImg, "Wood Axe", "A makeshift axe made of wood.", 1);
  woodShovel = new ItemGroup(woodShovelInvImg, woodShovelGroundImg, "Shovel", "A makeshift shovel made of wood.", 1);
  woodPickaxe = new ItemGroup(woodPickaxeInvImg, woodPickaxeGroundImg, "Wood Pickaxe", "A makeshift pickaxe made of wood.", 1);
  stoneAxe = new ItemGroup(stoneAxeInvImg, stoneAxeGroundImg, "Stone Axe", "A somewhat better quality axe made from stone.", 1);
  stoneShovel = new ItemGroup(stoneShovelInvImg, stoneShovelGroundImg, "Stone Shovel", "A somewhat better quality shovel made from stone.", 1);
  stonePickaxe = new ItemGroup(stonePickaxeInvImg, stonePickaxeGroundImg, "Stone Pickaxe", "A somewhat better quality pickaxe made from stone.", 1);
  ironAxe = new ItemGroup(ironAxeInvImg, ironAxeGroundImg, "Iron Axe", "A reliable axe made from iron.", 1);
  ironShovel = new ItemGroup(ironShovelInvImg, ironShovelGroundImg, "Iron Shovel", "A reliable shovel made from iron.", 1);
  ironPickaxe = new ItemGroup(ironPickaxeInvImg, ironPickaxeGroundImg, "Iron Pickaxe", "A reliable pickaxe made from iron.", 1);
  */
  
  //Map item IDs to the item type they represent
  //Example: itemTypes[0] == itemTypes[DRIFTWOOD] == driftwood
  
  //Common washUp() items
  itemTypes[DRIFTWOOD] = driftwood;
  itemTypes[STICK] = stick;
  itemTypes[SCRAPPLASTIC] = scrapPlastic;
  itemTypes[SCRAPGLASS] = scrapGlass;
  itemTypes[SHELL] = shell;
  itemTypes[BONE] = bone;
  
  //Uncommon washUp() items
  itemTypes[PLASTICBOTTLE] = plasticBottle;
  itemTypes[GLASSBOTTLE] = glassBottle;
  itemTypes[DUCTTAPE] = ductTape;
  itemTypes[WOODPLANK] = woodPlank;
  
  //Rare washUp() items
  itemTypes[COPPERWIRE] = copperWire;
  itemTypes[FISHINGLINE] = fishingLine;
  
  //Other items
  itemTypes[PLASTICWATERBOTTLE] = plasticWaterBottle;
  itemTypes[GLASSWATERBOTTLE] = glassWaterBottle;
  itemTypes[WORKBENCH] = workbench;
  
  /*
  //Mineables
  itemTypes[IRONORE] = ironOre;
  itemTypes[COPPERORE] = copperOre;
  itemTypes[COAL] = coal;
  itemTypes[DIRT] = dirt;
  itemTypes[SAND] = sand;
  itemTypes[STONE] = stone;
  
  //Other materials
  itemTypes[ROCK] = rock;
  itemTypes[CHARCOAL] = charcoal;
  
  //Farming
  itemTypes[FERTILIZER] = fertilizer;
  itemTypes[OAKSEED] = oakSeed;
  itemTypes[PALMSEED] = palmSeed;
  itemTypes[COCONUT] = coconut;
  itemTypes[HOE] = hoe;
  
  //Wood tools
  itemTypes[WOODFISHINGPOLE] = woodFishingPole;
  itemTypes[WOODAXE] = woodAxe;
  itemTypes[WOODSHOVEL] = woodShovel;
  itemTypes[WOODPICKAXE] = woodPickaxe;
  
  //Stone tools
  itemTypes[STONEAXE] = stoneAxe;
  itemTypes[STONESHOVEL] = stoneShovel;
  itemTypes[STONEPICKAXE] = stonePickaxe;
  
  //Iron tools
  itemTypes[IRONAXE] = ironAxe;
  itemTypes[IRONSHOVEL] = ironShovel;
  itemTypes[IRONPICKAXE] = ironPickaxe;
  */
  
  //Instantiate Crafting Recipes
  woodPlankRecipe = new CraftingRecipe("Wood Plank (x4)", woodPlank, 4, driftwood, 1, true);
  stickRecipe = new CraftingRecipe("Stick (x4)", stick, 4, woodPlank, 1, true);
  scrapPlasticRecipe = new CraftingRecipe("Scrap Plastic (x3)", scrapPlastic, 3, plasticBottle, 1, true);
  scrapGlassRecipe = new CraftingRecipe("Scrap Glass (x3)", scrapGlass, 3, glassBottle, 1, true);
  workbenchRecipe = new CraftingRecipe("Workbench (x1)", workbench, 1, woodPlank, 4, true);
  
  //Add crafting recipes to HashMap of crafting recipes
  craftingRecipes = new HashMap <Integer, CraftingRecipe> ();
  
  craftingRecipes.put(WOODPLANK, woodPlankRecipe);
  craftingRecipes.put(STICK, stickRecipe);
  craftingRecipes.put(SCRAPPLASTIC, scrapPlasticRecipe);
  craftingRecipes.put(SCRAPGLASS, scrapGlassRecipe);
  craftingRecipes.put(WORKBENCH, workbenchRecipe);
  
  numCraftingRecipes = craftingRecipes.size();
  
  //Make an ArrayList of all recipes that are known from the beginning
  knownRecipes = new ArrayList <CraftingRecipe> ();
  
  for(int i = 0; i < numItemTypes; i++) {
    CraftingRecipe recipe = craftingRecipes.get(i);
    if(recipe != null && recipe.unlocked == true) {
      //println("Recipe: " + recipe.name);
      knownRecipes.add(recipe);
    }
  }
  //println(craftingRecipes.size());
  //println(knownRecipes.size());
  //println(knownRecipes.get(0).name);
  
  //Instantiate BlockGroups
  workbenchBlock = new BlockGroup(workbench, 100);
  
  //Add block types to HashMap of block types
  blocks = new HashMap <Integer, BlockGroup> ();
  
  blocks.put(WORKBENCH, workbenchBlock);
  
  numBlockTypes = blocks.size();
  
}

void draw() {
  m = millis();
  if(screen == 0) {
    titleScreen();
  } else if(screen == 1) {
    homeScreen();
  } else if(screen == 2) {
    newGameScreen();
  } else if(screen == 3) {
    gameScreen(); 
  }
}

void titleScreen() {
  background(0, 255, 255);
  fill(0);
  
  textSize(40);
  text("Picking Up Garbage on the Beach Simulator", width/2, 150);
  textSize(40);
  text("2019", width/2, 195);
  line(275, 230, 749, 230);
  
  r = m/5 % 255;
  fill(r, 255, 255);
  textSize(50);
  text("Click to start", width / 2, 260); 
}
void homeScreen() {
  background(0, 255, 255);
  newGameBtn.draw();
}

void newGameScreen() {
  background(0, 255, 255);
  //Add some options for the world
}

void gameScreen() {
  int itemsCreated;
  drawWorld();
  
  //println("Mouse X: " + mouseX);
  //println("Mouse Y: " + mouseY);
  
  if(!showInv) {
    //Every random amount of seconds, a new item washes up on the shore
    if(millis() > washUpTimer + timeUntilWashUp) {
    
      //chooseRandomWashUpItem().washUp();
      chooseRandomWashUpItem().washUp();
      washUpTimer = millis();
      timeUntilWashUp = 1000; //* ((int) random(1, 21));
    }
  }
    
  //For each item type
  for(int ID = 0; ID < numItemTypes; ID++) {
    ItemGroup itemType = itemTypes[ID];
    //For each item of that type on the ground
    itemsCreated = itemType.itemsCreated;
    //println(itemsCreated);
    for(int index = 0; index < itemsCreated; index++) {
      if(itemType.itemsOnGround.containsKey(index)) {
        //Draw it
        itemType.drawOnGround(index);
        
        if(itemType.isTouchingPlayer(index, player)) {
          //Pick up that item
          itemType.pickUp(index);
        }
      }
    }
  }
  
  //For each possible block type
  for(int i = 0; i < numItemTypes; i++) {
    BlockGroup block = blocks.get(i);
    if(block != null) {
      //For each block of that type that has been placed
      for(int index = 0; index < block.numBlocksPlaced; index++) {
        //Draw it
        block.draw(index);
      }
    }
  }
  
  player.move();
  player.draw();
  toolbar.draw();
  
  if(showInv) {
    //Draw inventory
    inventory.draw();
  }
}

/*
void loadWorld() {
  for(int i = 0; i <= 4; i++) {
    for(int j = 0; j <= 7; j++) {
       
    }
  }
}
*/

void drawWorld() {
  background(0, 100, 255);
  noStroke();
  fill(210, 180, 140);
  rect(64, 32, 896, 512, 30);
  fill(0, 180, 0);
  rect(128, 96, 768, 384, 30);
}

ItemGroup chooseRandomWashUpItem() {
  ItemGroup item;
  
  int itemID;
  int rarityNum = (int) random(1, 11);
  
  //Common, 80% chance
  if(1 <= rarityNum && rarityNum <= 6) {
     itemID = (int) random(DRIFTWOOD, BONE + 1);
     item = itemTypes[itemID];
     
  //Uncommon, 15% chance
  } else if(7 <= rarityNum && rarityNum <= 9) {
     itemID = (int) random(PLASTICBOTTLE, WOODPLANK + 1);
     item = itemTypes[itemID];
     
  //Rare, 5% chance
  } else {
     itemID = (int) random(COPPERWIRE, FISHINGLINE + 1);
     item = itemTypes[itemID];
  }
  return item;
}

public void mousePressed() {
  itemTypes.toString();
  if(screen == 0) {
     screen = 1;
     
  } else if(screen == 1 && newGameBtn.hovered()) {
     screen = 2;
     
  } else if(screen == 2) {
     screen = 3;
     
     player = new Player();
     inventory = new Inventory();
     toolbar = new Toolbar();
     washUpTimer = millis();
     timeUntilWashUp = 1000; //* ((int) random(1, 21));
     //loadWorld();
     
  } else if(screen == 3){
     if(showInv) {
       inventory.processInventoryClick();
    }
  }
}

public void keyPressed() {
  if(!showInv) {
    player.setMove(keyCode, true);
  } else {
    if(key == 'c') {
      inventory.crafting = !inventory.crafting; 
    }
  }
  if(key == SHIFT && !player.sprinting) {
       player.sprinting = true;
  }
  if(key == 'i') {
    if(showInv) {
      showInv = false; 
    } else {
      showInv = true; 
    }
  }
  if(key == 'z') {
      workbenchBlock.place();
  }
}

public void keyReleased() {
   player.setMove(keyCode, false);
}
