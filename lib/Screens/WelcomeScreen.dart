import 'package:flutter/material.dart';
import 'package:ui_practice/Screens/Bookmarks.dart';
import 'package:ui_practice/HelperClass/CustomColors.dart';
import 'package:ui_practice/Widgets/CustomListTile.dart';
import 'package:ui_practice/Screens/IngredientsDetails.dart';
import 'MainScreen.dart';
import 'DrinkDetailsDark.dart';
import 'package:ui_practice/Widgets/TextWithLine.dart';
import 'package:ui_practice/HelperClass/APIHelper.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var randomCocktailURL = "https://www.thecocktaildb.com/api/json/v1/1/random.php";
  var drinks, categories, ingredients;
  int key = 0;
  bool _load = false;
  List allIngredients;
  Map<String,String> images = {
    "Ordinary Drink" : "ordinary_drink",
    "Cocktail" : "cocktail",
    "Milk / Float / Shake" : "shake",
    "Other/Unknown" : "others",
    "Cocoa" : "cocoa",
    "Shot" : "shot",
    "Coffee / Tea" : "tea",
    "Homemade Liqueur" : "homemade",
    "Punch / Party Drink" : "punch",
    "Beer" : "beer",
    "Soft Drink / Soda" : "soda",
  };
  @override 
  void initState(){
    super.initState();
    fetchData();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: lightBackground,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Text(
                    'Recommended',
                    style: TextStyle(
                      color: blackText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),),
                ),

                //Recommended Drinks

                drinks == null || (_load && key == 1) ?  Padding(child: Center(child: CircularProgressIndicator(backgroundColor: blackText,)), padding: EdgeInsets.all(40.0),) 
                   : CustomListItem(
                      thumbnail: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Image.network(drinks['strDrinkThumb'])),
                      drink: drinks,
                      onPressed: () => {
                       setState((){
                           key = 1;
                           _load = true;
                           openRandomDrink();}),
                        },),
               
                //Categories of Drinks
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextWithLine(text: "Categories", color: blackText, fontSize: 20.0,),
                ),

                
                categories != null  ? Container(
                                        margin: EdgeInsets.only(top: 8.0),
                                        width: MediaQuery.of(context).size.width,
                                        // height: (height*38.7)/100,
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: size.width/(size.height/1.6)),
                                        itemCount: categories.length,
                                        itemBuilder: (context,index){
                                          String category = categories[index]["strCategory"];
                                          return _customCard(category);
                                        }),
                ) : Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(child: CircularProgressIndicator(backgroundColor: light,),),
                ),
              ],
            ),
          ),
        ),
            ),
    );
  }

  Widget _customCard(String category){
    return InkWell(
            onTap: (){
                openList(category, "c");},
            child: Padding(
            padding: const EdgeInsets.all(4.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Image.asset('assets/categories/${images['$category']}.jpg',fit: BoxFit.cover,))),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(category, style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
              ),
            ),
          );
  }
  Widget _buildAppBar(){
    return AppBar( 
          title: Text("Madira App", style: TextStyle(fontWeight: FontWeight.w600, color: whiteText),),
          actions: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon:Icon(Icons.search),
                  onPressed: () => openIngredientPage(),),
               IconButton(icon: Icon(Icons.favorite), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Bookmarks()));},),
                IconButton(icon: Icon(Icons.refresh), onPressed: (){
                  setState((){drinks = null;});
                  fetchData();
                  
                })
              ],
            ),
          ],
          backgroundColor: light,
          );
  }


  openIngredientPage(){
    Navigator.pushNamed(context, '/ingredientsPage');
  }
  
  fetchData() async{
   drinks = await getRandomCocktail(randomCocktailURL);
   setState(() {
   });
  }

  fetchCategories() async{
  categories = await getCategoryList("https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list");
  setState(() {});
  }

  openList(String data, String prefix){
   prefix != "i" ? Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(category: data, prefix: prefix),fullscreenDialog: true))
    : Navigator.push(context, MaterialPageRoute(builder: (context) => IngredientsDetails(name: data),fullscreenDialog: true));
  }
  
  openRandomDrink() async {
    final result = await Navigator.push(
                      context,
                    MaterialPageRoute(
                      builder: (context) => DrinkDetailsDark(directResponse: drinks),
                        fullscreenDialog: true,
             )
      );
    if(result == true || result == null){
      setState(() {
        _load = false;
        key = 0;
      });
    }
  }

}



