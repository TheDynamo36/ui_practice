
import 'package:flutter/material.dart';
import 'package:ui_practice/IngredientsDetails.dart';
import 'CustomColors.dart';
import 'SharedPreferenceHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DrinkDetailsDark extends StatefulWidget {
  final response;

  const DrinkDetailsDark({Key key,  @required this.response}) : super(key: key);

  @override
  _DrinkDetailsDarkState createState() => _DrinkDetailsDarkState();
}

class _DrinkDetailsDarkState extends State<DrinkDetailsDark> {
var drinkDetails;
var ingredientsList = [];
var measurementList = [];
var _favourite = false;
Color ourBlack = Color(0xFF121619);
SharedPreferences preference;
SharedPreferenceHelper prefs;
 @override
 void initState(){
   super.initState();
   updateUI(widget.response);
   
}

 void updateUI(var response){
   setState(() {
     if(response == null){
       return;
     }
     drinkDetails = new Details(response['idDrink'], response['strDrink'], response['strTags'], response['strCategory'],
                               response['strIBA'], response['strAlcoholic'], response['strGlass'],
                               response['strInstructions'], response['strDrinkThumb']);
     for(int i = 1 ; i <= 15 ; i++){
       if(response['strIngredient$i'] == null || response['strIngredient$i'].toString().length < 3)
       break;
       ingredientsList.add(response['strIngredient$i']);
       measurementList.add(response['strMeasure$i'] ?? "-");
     }
   });
   getSahredPreferences();
 }
 
 getSahredPreferences() async{
   preference = await SharedPreferences.getInstance();
   prefs = new SharedPreferenceHelper(preference);
   prefs.checkFavourite(drinkDetails.id) ? setState((){_favourite = true;}) : setState((){_favourite = false;});
 }
 toggleBookmark(){
   if(!_favourite) {
     prefs.setData(widget.response);
     setState((){_favourite = true;});
   }else{
     prefs.removeData(drinkDetails.id);
     setState((){_favourite = false;});
   }
 }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SafeArea(
                      child: Scaffold(
              // appBar: AppBar(
              //   elevation: 0.0,
              //   backgroundColor: light,
              //        leading: new IconButton(
              //         icon: new Icon(Icons.arrow_back),
              //         onPressed: (){Navigator.pop(context,true);}
              //      ),
              //   ),
              backgroundColor: lightBackground,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [g1,g2,g3,g4],
            //     end: Alignment.topRight,
            //     begin: Alignment.bottomLeft,
            //     tileMode: TileMode.clamp,
            //     ),
            //     ),
            body: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 
                  //Main Beverage Image

                  Stack(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.width,
                        child: Hero(
                        child: ClipRRect(
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
                                child: Image(image: NetworkImage("${drinkDetails.image}") ?? AssetImage("assets/noimg.jpg"),
                               ),
                        ),
                        tag: drinkDetails.id,
                       ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [new BoxShadow(color: Colors.black26, blurRadius: 22.0)]),
                            child: IconButton(
                              iconSize: 30.0,
                              icon: Icon(Icons.keyboard_arrow_left,color: Colors.white),
                              onPressed: (){Navigator.pop(context,true);},
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [new BoxShadow(color: Colors.black26, blurRadius: 22.0)]),
                            child: IconButton(
                              iconSize: 30.0,
                              icon: Icon(_favourite ? Icons.favorite : Icons.favorite_border, color: _favourite ? Colors.red : Colors.white),
                              onPressed: (){toggleBookmark();},
                            ),
                          ),

                        ],
                      )
                    ]
                  ),
                 
                  SizedBox(height: 8.0),
                  
                  //Beverage Title

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: Text(
                      drinkDetails.name,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: blackText,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  
                  //Alcoholic...... ??

                  Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("${drinkDetails.alcoholic ?? "Unidentified"}", style: TextStyle(color: blackText),),
                        ),
                  

                  //Category
                  //Comment
                  //Glass

                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
                    child: Column(
                      children: <Widget>[
                        RowText(text: "${drinkDetails.category}", imgName: "categoryblack"),
                        RowText(text: "${drinkDetails.tags ?? "No Comments"}", imgName: "commentcolor",),
                        RowText(text: "${drinkDetails.glass.toString().length < 4 ? "-" : drinkDetails.glass}", imgName: "glassred"),
                      ],
                    ),
                  ),
                  

                  //Ingredients

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWithLine(text: "Ingredients",color: blackText,),
                  ),
                  SizedBox(height:10.0),

                  Container(
                    width: double.maxFinite,
                    height: height > 680 ? 165 : (height*24.5/100),
                    child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: ingredientsList.length,
                    itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){openDetails(ingredientsList[index]);},
                        child: Container(  
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.0)],
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF45536D),
                        ),
                        
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(4),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                             height: (height*14.5/100),
                              child: Image.network(
                                         "https://www.thecocktaildb.com/images/ingredients/${ingredientsList[index].trim()}-Medium.png",
                              width: (height*15/100),
                              fit: BoxFit.fill,),
                          ),
                          SizedBox(height: 4.0,),
                          Text(
                            "${measurementList[index]}",
                            maxLines: 2,
                            style: TextStyle(fontSize: 16, color: whiteText, fontWeight: FontWeight.w500),),
                          
                          Flexible(
                          child: Text(
                            "${ingredientsList[index]}",
                            maxLines: 2,
                            style: TextStyle(fontSize: 12, color: whiteText, fontWeight: FontWeight.w400),),
                            ),
                          ],),
                      ),
                    );
                      }),
                  ),

                  // for(int i = 0 ; i < measurementList.length ; i++)
                  //  new Padding(
                  //     padding: const EdgeInsets.fromLTRB(16.0,0.0,20.0,8.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: <Widget>[
                  //         Expanded(
                  //           flex: 2,
                  //           child: Text(
                  //               "${measurementList[i]}            ",
                  //               style: TextStyle(
                  //                 color: whiteText,
                  //                 fontSize: 14.0,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //         ),
                          
                  //         Expanded(
                  //           flex: 3,
                  //             child: Text(
                  //             ingredientsList[i],
                  //             style: TextStyle(
                  //               color: whiteText,
                  //               fontSize: 14.0,
                  //               fontWeight: FontWeight.w700,
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  

                  SizedBox(height:10.0),



                  //Instructions

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWithLine(text: "Instructions", color: blackText,),
                  ) ,
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16.0,0.0,8.0,24.0),
                      child: Text(
                            drinkDetails.instructions.toString(),
                            style: TextStyle(
                              color: blackText,
                              height: 1.7,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),),
        
                ],
              ),
            ),
            
        ),
          ),
    );
  }

  openDetails(String ingredient){
    Navigator.push(context, MaterialPageRoute(builder: (context) => IngredientsDetails(name: ingredient,imageURL: "https://www.thecocktaildb.com/images/ingredients/${ingredient.trim()}.png")));
    }
}



