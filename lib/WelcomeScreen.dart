import 'package:flutter/material.dart';
import 'package:ui_practice/AllIngredients.dart';
import 'package:ui_practice/CustomColors.dart';
import 'package:ui_practice/IngredientsDetails.dart';
import 'MainScreen.dart';
import 'DrinkDetailsDark.dart';
import 'package:auto_size_text/auto_size_text.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // var nonAlcoholicCocktailImage = "https://www.invaluable.com/blog/wp-content/uploads/2018/07/art-and-cocktails-hero.jpg";
  // var alcoholicCocktailImage = "https://www.liquor.com/thmb/FpQjWZNtBBC8PoW8aPfUj7cysYg=/720x720/filters:fill(auto,1)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__05__08110806__negroni-720x720-recipe-7c1b747a616f4659af4008d025ab55df.jpg";
  var randomCocktailURL = "https://www.thecocktaildb.com/api/json/v1/1/random.php";
  var drinks, categories, ingredients;
  int key = 0;
  bool _load = false;
  List allIngredients;

  @override 
  void initState(){
    super.initState();
    fetchData();
    fetchCategories();
    fetchIngredients();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Image(
          image: AssetImage("assets/ic_launcher.png"),
                    ), 
          title: Text("MADIRA", style: TextStyle(fontFamily: "Playfair", fontWeight: FontWeight.bold, letterSpacing: 2.0),),
          backgroundColor: Colors.transparent,
          elevation: 2.0,
          ),
        backgroundColor: dark,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:12.0),
                  child: Text(
                    'Recommended',
                    style: TextStyle(
                      color: whiteText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),),
                ),

                //Recommended Drinks

                drinks == null || (_load && key == 1) ?  Padding(child: CircularProgressIndicator(), padding: EdgeInsets.all(35.0),) 
                : TopButtons(text: drinks['strDrink'],url: "${drinks['strDrinkThumb']}/preview", myFunction: () => setState((){
                                     key = 1;
                                     _load = true;
                                    customfunction();
                }),),
                
                
                //Categories of Drinks
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: TextWithLine(text: "Categories"),
                ),

                
                categories != null  ? Container(
                  width: MediaQuery.of(context).size.width,
                  // height: (height*38.7)/100,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.5, ),//MediaQuery.of(context).size.width /
                      // (MediaQuery.of(context).size.height / 3.5),)  ,
                    itemCount: categories.length,
                    itemBuilder: (context,index){
                      return Container(
                        height: 10.0,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          boxShadow: [new BoxShadow(color: Colors.black26, blurRadius: 10.0)],
                          color: light,
                          borderRadius: BorderRadius.circular(10.0),  
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: AutoSizeText(
                                categories[index]["strCategory"],
                                softWrap: true,
                                maxFontSize: 12,
                                minFontSize: 10,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(color: whiteText),),
                              onTap: (){
                                openList(categories[index]["strCategory"], "c", "");},),
                          ),
                        ),
                        );
                    }),
                ) : Center(child: CircularProgressIndicator(),),


                Container(height: 1, width: MediaQuery.of(context).size.width, color: whiteText, padding: EdgeInsets.all(8),),

                Container(
                        margin: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          boxShadow: [new BoxShadow(color: Colors.black26, blurRadius: 10.0)],
                          color: light,
                          borderRadius: BorderRadius.circular(10.0),  
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: AutoSizeText(
                                "Search By Ingredients",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(color: whiteText),),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AllIngredients(), fullscreenDialog: true));},),
                          ),
                        ),
                        ),
                // Ingredients List
                //Categories of Drinks
                // Padding(padding: EdgeInsets.only(top: 12.0),),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                //   child: TextWithLine(text: "Top 100 Ingredients"),
                // ),

                // ingredients != null  ? Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 500.0,
                //   child: GridView.builder(
                //     shrinkWrap: true,
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3,
                //       childAspectRatio: MediaQuery.of(context).size.width /
                //       (MediaQuery.of(context).size.height / 1.5),
                //       ),
                //     itemCount: ingredients.length,
                //     itemBuilder: (context,index){
                //       return Container(
                //         margin: EdgeInsets.all(8.0),
                //         decoration: BoxDecoration(
                //           boxShadow: [new BoxShadow(color: Colors.black26, blurRadius: 10.0)],
                //           color: light,
                //           borderRadius: BorderRadius.circular(10.0),  
                //         ),
                //         child: Center(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: InkWell(
                //               child: Column(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: <Widget>[
                //                   Hero(
                //                     tag: ingredients[index]["strIngredient1"],
                //                     child: Image(image: NetworkImage("https://www.thecocktaildb.com/images/ingredients/${ingredients[index]["strIngredient1"]}-small.png") ?? AssetImage("assets/noimg.jpg"))),
                //                   AutoSizeText(
                //                     ingredients[index]["strIngredient1"],
                //                     textAlign: TextAlign.center,
                //                     maxLines: 2,
                //                     style: TextStyle(color: whiteText),),
                //                 ],
                //               ),
                //               onTap: (){
                //                 openList(ingredients[index]["strIngredient1"],"i","https://www.thecocktaildb.com/images/ingredients/${ingredients[index]["strIngredient1"]}.png");},),
                //           ),
                //         ),
                //         );
                //     }),
                // ) : Center(child: CircularProgressIndicator(),)

                // Row(
                //   children: <Widget>[
                //     (_load && key == 2) ? Padding(child: CircularProgressIndicator(), padding: EdgeInsets.all(35.0),)
                //     : TopButtons(text:"Cocktail", url: null, image: "assets/cocktail.jpg",myFunction:() => setState((){
                //                        key = 2;
                //                        _load = true;
                //                        openList("Cocktail");
                // }),),
                    
                //     (_load && key == 3) ? Padding(child: CircularProgressIndicator(), padding: EdgeInsets.all(35.0),)
                //     : TopButtons(text:"Alcoholic", url: nonAlcoholicCocktailImage, image: null,myFunction: () => setState((){
                //                        key = 3;
                //                        _load = true;
                //                        customfunction();
                // }),),
                //   ],
                // ),
                
              ],
            ),
          ),
        ),
            ),
    );
  }

  
  fetchData() async{
   drinks = await getByURL(randomCocktailURL);
  //  print(drinks);
   setState(() {
   });
  }

  fetchCategories() async{
  categories = await getList("https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list");
  setState(() {
    print(categories);
  });
  }

  fetchIngredients() async{
    ingredients = await getList("https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list");
  setState(() {  });
  }

  openList(String data, String prefix, String imageURL){
   prefix != "i" ? Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(category: data, prefix: prefix),fullscreenDialog: true))
    : Navigator.push(context, MaterialPageRoute(builder: (context) => IngredientsDetails(name: data, imageURL: imageURL,),fullscreenDialog: true));
  }
  
  
  customfunction() async{
    var data = await getDataUsingID(drinks['idDrink']);
    final result = await Navigator.push(
                      context,
                    MaterialPageRoute(
                      builder: (context) => DrinkDetailsDark(response: data),
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
  
  loadAllIngredients() async{
    
  }

}



