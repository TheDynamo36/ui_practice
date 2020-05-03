// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:ui_practice/CustomColors.dart';
//import 'package:ui_practice/DrinkDetail.dart';
import 'DrinkDetailsDark.dart';
import 'package:auto_size_text/auto_size_text.dart';

class IngredientsDetails extends StatefulWidget {
final name, prefix, imageURL;
const IngredientsDetails({Key key, @required this.name,  @required this.prefix,  @required this.imageURL}) : super(key : key);
  @override
  _IngredientsDetailsState createState() => _IngredientsDetailsState();
}

class _IngredientsDetailsState extends State<IngredientsDetails> {
  var ingredient;
  @override 
  void initState(){
    super.initState();
    fetchData();
  }

  fetchData() async{
   ingredient = await getIngredientDetails(widget.name);
   setState(() {
     print(ingredient);
   });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
          appBar: AppBar(leading:new IconButton(
                icon: new Icon(Icons.arrow_back, color: dark,),
                onPressed: (){Navigator.pop(context,true);}
             ),
        backgroundColor: Color(0xFFDDE7F0),
        title: Text(widget.name, style: TextStyle(color: dark,),),
        elevation: 0,
        
        ),
        backgroundColor: lightBackground,//dark,//lightBackground,
        
        
        body: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget> [
                    Container(
                      padding: EdgeInsets.all(4.0),
                      color: Color(0xFFDDE7F0),
                      child: Hero(
                      tag: widget.name,
                      child: Image(image: NetworkImage(widget.imageURL)),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey[600], blurRadius: 10.0,)]),
                      child: RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        onPressed: (){},
                        color: Color(0xFF43576b),
                        child: Text("View Drinks",style: TextStyle(color: lightBackground),),
                      ),
                    )
                ]
              ),
              
              ingredient == null ? Center(child: CircularProgressIndicator(backgroundColor: light)) :
                  Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        DrinkHeader(top: ingredient["strType"], bottom:"Type"),
                        DrinkHeader(top: ingredient["strAlcohol"], bottom:"Alcoholic"),
                        DrinkHeader(top: "${ingredient["strABV"] ?? "0"}%", bottom:"Strength"),
                      ],
                      ),
                      ),
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextWithLine(text: "Summary",color: dark,fontFamily: "Playfair",),
                       ),
                      Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        ingredient["strDescription"] ?? "No Description",
                        textAlign: TextAlign.justify, 
                        style: TextStyle(
                          fontSize: 16.0,
                          color: dark,//whiteText, 
                          height: 1.5, 
                          letterSpacing: 0.7,
                          ),),
                      ),
                      ],),

              ],
          ),
        ) ,
        ),
    );
  }
}

class DrinkHeader extends StatelessWidget {
  const DrinkHeader({
    Key key,
    @required this.top,@required this.bottom,
  }) : super(key: key);

  final String top, bottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:  MainAxisAlignment.center,
      children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(top ?? "-",style: TextStyle(fontWeight: FontWeight.bold, color: dark),),
      ),
      Text(bottom),
    ],);
  }
}
