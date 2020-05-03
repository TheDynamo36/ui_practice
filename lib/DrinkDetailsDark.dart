import 'package:flutter/material.dart';
import 'CustomColors.dart';


class DrinkDetailsDark extends StatefulWidget {
  final response;

  const DrinkDetailsDark({Key key,  @required this.response}) : super(key: key);

  @override
  _DrinkDetailsDarkState createState() => _DrinkDetailsDarkState();
}

class _DrinkDetailsDarkState extends State<DrinkDetailsDark> {
var drinkDetails;
var ingredientsList = new List<String>();
var measurementList = new List<String>();

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
                      RowText(text: "${drinkDetails.tags ?? "Classic"}", imgName: "comment",),
                      RowText(text: "${drinkDetails.glass.toString().length < 4 ? "-" : drinkDetails.glass}", imgName: "glass"),
                    ],
                  ),
                ),
                

                //Ingredients

                TextWithLine(text: "Ingredients"),
                SizedBox(height:24.0),
                for(int i = 0 ; i < measurementList.length ; i++)
                 new Padding(
                    padding: const EdgeInsets.fromLTRB(16.0,0.0,20.0,8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                              "${measurementList[i]}            ",
                              style: TextStyle(
                                color: whiteText,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        ),
                        
                        Expanded(
                          flex: 3,
                            child: Text(
                            ingredientsList[i],
                            style: TextStyle(
                              color: whiteText,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                

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
}



