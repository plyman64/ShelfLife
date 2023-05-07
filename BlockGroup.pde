
class BlockGroup {
  
  int numBlocksPlaced;
  
  ItemGroup itemEquivalent;
  int durability;
  HashMap <Integer, int []> blockTypesOnGround;
  
  String name;
  PImage img;
  
  BlockGroup() { 
    //Missing texture
  }
  
  BlockGroup(ItemGroup tempItemEquivalent, int tempDurability) {
    numBlocksPlaced = 0;
    
    itemEquivalent = tempItemEquivalent;
    durability = tempDurability;
    blockTypesOnGround = new HashMap <Integer, int []> ();
    
    name = itemEquivalent.name;
    img = itemEquivalent.groundImg;
    
  }
  
  void place() {
    println("Workbench placed");
    blockTypesOnGround.put(numBlocksPlaced++, new int [] {player.x, player.y});
  }
  
  void draw(int index) {
    image(img, blockTypesOnGround.get(index)[0], blockTypesOnGround.get(index)[1]);
  }
}
