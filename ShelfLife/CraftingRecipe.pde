
class CraftingRecipe {
 
  String name;
  
  ItemGroup item1;
  int numItem1;
  ItemGroup item2;
  int numItem2;
  ItemGroup item3;
  int numItem3;
  int numIngredients;

  ItemGroup product;
  int numProduct;
  
  boolean unlocked;
  
  //For recipes with 1 ingredient
  CraftingRecipe(String tempName, ItemGroup tempProduct, int tempNumProduct, ItemGroup tempItem1, int tempNumItem1, boolean status) {
   
    numIngredients = 1;
    
    name = tempName;
    item1 = tempItem1;
    numItem1 = tempNumItem1;
    product = tempProduct;
    numProduct = tempNumProduct;
    unlocked = status;
    
  }
  
  //For recipes with 2 ingredients
  CraftingRecipe(String tempName, ItemGroup tempProduct, int tempNumProduct, ItemGroup tempItem1, int tempNumItem1, ItemGroup tempItem2, int tempNumItem2, boolean tempUnlocked) {
   
    numIngredients = 2;
    
    name = tempName;
    item1 = tempItem1;
    numItem1 = tempNumItem1;
    item2 = tempItem2;
    numItem2 = tempNumItem2;
    product = tempProduct;
    numProduct = tempNumProduct;
    unlocked = tempUnlocked;
    
  }
  
  //For recipes with 3 ingredients
  CraftingRecipe(String tempName, ItemGroup tempProduct, int tempNumProduct, ItemGroup tempItem1, int tempNumItem1, ItemGroup tempItem2, int tempNumItem2, ItemGroup tempItem3, int tempNumItem3, boolean tempUnlocked) {
   
    numIngredients = 3;
    
    name = tempName;
    item1 = tempItem1;
    numItem1 = tempNumItem1;
    item2 = tempItem2;
    numItem2 = tempNumItem2;
    item3 = tempItem3;
    numItem3 = tempNumItem3;
    product = tempProduct;
    numProduct = tempNumProduct;
    unlocked = tempUnlocked;
    
  }
  
  void unlock() {
    unlocked = true;
    
    //Recreate list of known recipes
    for(int i = 0; i < craftingRecipes.size(); i++) {
      CraftingRecipe recipe = craftingRecipes.get(i);
      if(recipe != null && recipe.unlocked == true) {
        knownRecipes.add(recipe);
      }
    }
  }
  
  boolean isUnlocked() {
    return unlocked;
  }
}
