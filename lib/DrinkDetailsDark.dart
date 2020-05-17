
import 'package:flutter/material.dart';
import 'package:ui_practice/IngredientsDetails.dart';
import 'CustomColors.dart';


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

Color ourBlack = Color(0xFF121619);


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
 }
 
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
                   leading: new IconButton(
                    icon: new Icon(Icons.arrow_back),
                    onPressed: (){Navigator.pop(context,true);}
                 ),
              ),
            backgroundColor: dark,
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

                Hero(
                  child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(image: NetworkImage("${drinkDetails.image}") ?? AssetImage("assets/noimg.jpg"),
                         ),
                  ),
                  tag: drinkDetails.id,
                ),
               
                SizedBox(height: 10.0),
                
                //Beverage Title

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    drinkDetails.name,
                    
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: whiteText,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                
                //Alcoholic...... ??

                Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("${drinkDetails.alcoholic ?? "Unidentified"}", style: TextStyle(color: whiteText),),
                      ),
                

                //Category
                //Comment
                //Glass

                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 8.0),
                  child: Column(
                    children: <Widget>[
                      RowText(text: "${drinkDetails.category}", imgName: "category"),
                      RowText(text: "${drinkDetails.tags ?? "No Comments"}", imgName: "comment",),
                      RowText(text: "${drinkDetails.glass.toString().length < 4 ? "-" : drinkDetails.glass}", imgName: "glass"),
                    ],
                  ),
                ),
                

                //Ingredients

                TextWithLine(text: "Ingredients"),
                SizedBox(height:10.0),

                Container(
                  width: double.maxFinite,
                  height: height > 680 ? 165 : (height*24.5/100),
                  child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: ingredientsList.length,
                  itemBuilder: (context,index){
                  return Container(

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          blurRadius: 5)],
                      borderRadius: BorderRadius.circular(10),
                      color: light,),
                    
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(4),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.network(
                                   "https://www.thecocktaildb.com/images/ingredients/${ingredientsList[index].trim()}-Medium.png",
                        width: (height*15/100),
                        fit: BoxFit.fill,),
                      Expanded(
                      child: Text(
                        "${measurementList[index]}",
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, color: whiteText),),
                        ),
                        
                        Expanded(
                      child: Text(
                        "${ingredientsList[index]}",
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, color: whiteText, fontWeight: FontWeight.bold),),
                        ),
                      ],),
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

                TextWithLine(text: "Instructions") ,
                SizedBox(height:16.0),
                Padding(
                    padding: const EdgeInsets.fromLTRB(16.0,0.0,8.0,24.0),
                    child: Text(
                          drinkDetails.instructions.toString(),
                          style: TextStyle(
                            color: whiteText,
                            height: 1.7,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),),
        
              ],
            ),
          ),
          
        ),
    );
  }

  gotoIngredientDetails(String ingredient){
    Navigator.push(context, MaterialPageRoute(builder: (context) => IngredientsDetails(name: ingredient,imageURL: "https://www.thecocktaildb.com/images/ingredients/${ingredient.trim()}-Medium.png")));
    }
}



