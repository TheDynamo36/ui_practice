import 'package:flutter/material.dart';
import 'CustomColors.dart';


class DrinkDetails extends StatefulWidget {
  final String url, text, id;
  final response;

  const DrinkDetails({Key key, @required this.url, @required this.text, @required this.id,  @required this.response}) : super(key: key);

  @override
  _DrinkDetailsState createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
var drinkDetails;
var ingredientsList = new List<String>();
var measurementList = new List<String>();

Color ourBlack = Color(0xFF121619);


 @override
 void initState(){
   super.initState();
   updateUI(widget.response);
 }

 void updateUI(dynamic response){
   setState(() {
     if(response == null){
       return;
     }
     drinkDetails = new Details(widget.id, widget.text, response[0]['strTags'], response[0]['strCategory'],
                               response[0]['strIBA'], response[0]['strAlcoholic'], response[0]['strGlass'],
                               response[0]['strInstructions'], widget.url);
     for(int i = 1 ; i <= 15 ; i++){
       if(response[0]['strIngredient$i'] == null || response[0]['strIngredient$i'].toString().length < 3)
       break;
       ingredientsList.add(response[0]['strIngredient$i']);
       measurementList.add(response[0]['strMeasure$i'] ?? "-");
     }
     print(ingredientsList);
     print(measurementList);
     print(drinkDetails.instructions);
   });
 }
 
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
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
                
                Hero(
                  child: Image(image: NetworkImage(widget.url),
                    ),
                  tag: widget.id,
                ),
               
                SizedBox(height: 10.0),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF1D2024),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                ),
               
                Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("${drinkDetails.alcoholic}"),
                      ),
                
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 8.0),
                  child: Column(
                    children: <Widget>[
                      RowText(text: "${drinkDetails.category}", imgName: "category"),
                      RowText(text: "${drinkDetails.tags ?? "Classic"}", imgName: "comment",),
                      RowText(text: "${drinkDetails.glass}", imgName: "glass"),
                    ],
                  ),
                ),
                
                TextWithLine(text: "Ingredients", ourBlack: ourBlack),
                
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
                                color: ourBlack,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                        ),
                        
                        Expanded(
                          flex: 3,
                            child: Text(
                            ingredientsList[i],
                            style: TextStyle(
                              color: ourBlack,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                
                TextWithLine(text: "Instructions", ourBlack: ourBlack) ,
                
                Padding(
                    padding: const EdgeInsets.fromLTRB(16.0,0.0,8.0,24.0),
                    child: Text(
                          drinkDetails.instructions.toString(),
                          style: TextStyle(
                            height: 1.7,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),),
        
              ],
            ),
          ),
          
        ),
    );
  }
}

class TextWithLine extends StatelessWidget {
  const TextWithLine({
    Key key,
    @required this.ourBlack, @required this.text
  }) : super(key: key);

  final Color ourBlack;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text,style: TextStyle(
            color: ourBlack,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            fontFamily: "Playfair",
            ),
            ),
          Container(
            margin: EdgeInsets.only(right: 30.0),
            width: MediaQuery.of(context).size.width/2+20,
          height: 1.5,
          color: ourBlack,
          ),
        ],)
    );
  }
}

class RowText extends StatelessWidget {
  const RowText({
    Key key,
    @required this.text, @required this.imgName
  }) : super(key: key);

  final text, imgName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Image(image: AssetImage('assets/$imgName.jpg'),
          ),
          width: 25.0,
          height: 25.0,
          ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Playfair",
              color: Color(0xFF121619),
              fontSize: 14,
              fontWeight: FontWeight.w500),),
        ),
      ],
    );
  }
}