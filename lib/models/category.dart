class Category{
  String name;
  String icon;
  Category(this.name,this.icon);
}
class CategoriesList{
  List<Category> categoriesList =[
    Category('Fruits', "images/fruit.png",),
    Category("Vegetables", "images/vegetable.png"),
    Category("Spices", "images/spicy-food.png")
  ];
  Category  getCategory(String category){
   return categoriesList.firstWhere((element) => element.name ==category);
  }
}