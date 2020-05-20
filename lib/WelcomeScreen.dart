import 'package:flutter/material.dart';
import 'package:ui_practice/Bookmarks.dart';
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
    //fetchIngredients();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar( 
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
          ),
        backgroundColor: lightBackground,
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
                      color: blackText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),),
                ),

                //Recommended Drinks

                drinks == null || (_load && key == 1) ?  Padding(child: Center(child: CircularProgressIndicator(backgroundColor: blackText,)), padding: EdgeInsets.all(40.0),) 
                // : TopButtons(text: drinks['strDrink'],url: "${drinks['strDrinkThumb']}/preview", myFunction: () => setState((){
                //                      key = 1;
                //                      _load = true;
                //                     customfunction();
                // }),),
                
                : InkWell(
                  onTap: () => setState((){
                    key = 1;
                    _load = true;
                    openRandomDrink();}),
                    child: Container(
                      margin: EdgeInsets.only(top:8.0),
                    padding: EdgeInsets.all(0.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [new BoxShadow(color: Colors.black45, blurRadius: 8.0)]),
                    height: 150.0,
                    child: Row(children: <Widget>[
                      SizedBox(
                          width: 149.0,
                          child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: Image.network("${drinks['strDrinkThumb']}/preview"
                          ),
                        ),
                      ),

                      Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                            AutoSizeText(
                              drinks['strDrink'],
                              maxLines: 3,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),),

                            Flexible(
                                flex: 2,
                                child: AutoSizeText(
                                "${drinks['strCategory']} | ${drinks['strAlcoholic']}",
                                minFontSize: 10,
                                maxLines: 2,),
                            ),
                            SizedBox(height: height*0.02,),
                            Text(
                              "Ingredients",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                ),
                            ),
                            SizedBox(height: height*0.005,),
                            for(int i = 1 ; i <= 3 ; i++)
                            Flexible(
                                child: AutoSizeText(
                                drinks['strIngredient$i'] != null ? "- ${drinks['strIngredient$i']}" : "", maxFontSize: 12, minFontSize: 10,),
                            ),
                            
                        ],),
                          ),
                      ),

                      Icon(Icons.navigate_next),
                    ],),
                  ),
                ),
                //Categories of Drinks
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextWithLine(text: "Categories", color: blackText, fontSize: 20.0,),
                ),

                
                categories != null  ? Container(
                  width: MediaQuery.of(context).size.width,
                  // height: (height*38.7)/100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 3,
                    //   childAspectRatio: 1.5, ),//MediaQuery.of(context).size.width /
                    //   // (MediaQuery.of(context).size.height / 3.5),)  ,
                    itemCount: categories.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                            openList(categories[index]["strCategory"], "c", "");},
                          child: Container(
                          height: 50.0,
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            boxShadow: [new BoxShadow(color: Colors.black26, blurRadius: 5.0)],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),  
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                AutoSizeText(
                                  categories[index]["strCategory"],
                                  softWrap: true,
                                  minFontSize: 10,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(color: blackText),),

                                  Icon(Icons.navigate_next),
                              ],
                            ),
                          ),
                          ),
                      );
                    }),
                ) : Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(child: CircularProgressIndicator(backgroundColor: light,),),
                ),


                // Container( margin: EdgeInsets.only(top: 8.0),height: 1, width: MediaQuery.of(context).size.width, color: blackText, padding: EdgeInsets.all(8),),

                // Container(
                //         margin: EdgeInsets.all(16.0),
                //         decoration: BoxDecoration(
                //           boxShadow: [new BoxShadow(color: Colors.black45, blurRadius: 8.0)],
                //           color: light,
                //           borderRadius: BorderRadius.circular(10.0),  
                //         ),
                //         child: Center(
                //           child: Padding(
                //             padding: const EdgeInsets.all(12.0),
                //             child: InkWell(
                //               child: AutoSizeText(
                //                 "Search By Ingredients",
                //                 textAlign: TextAlign.center,
                //                 maxLines: 2,
                //                 style: TextStyle(color: whiteText),),
                //               onTap: (){
                //                 openIngredientPage();},),
                //           ),
                //         ),
                //         ),
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
  openIngredientPage(){
    Navigator.pushNamed(context, '/ingredientsPage');
  }
  
  fetchData() async{
   drinks = await getByURL(randomCocktailURL);
   setState(() {
   });
  }

  fetchCategories() async{
  categories = await getList("https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list");
  setState(() {});
  }

  // fetchIngredients() async{
  //   ingredients = await getList("https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list");
  // setState(() {  });
  // }

  openList(String data, String prefix, String imageURL){
   prefix != "i" ? Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(category: data, prefix: prefix),fullscreenDialog: true))
    : Navigator.push(context, MaterialPageRoute(builder: (context) => IngredientsDetails(name: data, imageURL: imageURL,),fullscreenDialog: true));
  }
  
  
  // customfunction() async{
  //   var data = await getDataUsingID(drinks['idDrink']);
  //   final result = await Navigator.push(
  //                     context,
  //                   MaterialPageRoute(
  //                     builder: (context) => DrinkDetailsDark(response: data),
  //                       fullscreenDialog: true,
  //            )
  //     );
  //   if(result == true || result == null){
  //     setState(() {
  //       _load = false;
  //       key = 0;
  //     });
  //   }
  // }
  
  openRandomDrink() async {
    final result = await Navigator.push(
                      context,
                    MaterialPageRoute(
                      builder: (context) => DrinkDetailsDark(response: drinks),
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



