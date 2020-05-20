// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:ui_practice/CustomColors.dart';
import 'package:ui_practice/MainScreen.dart';

class IngredientsDetails extends StatefulWidget {
final name, imageURL;
const IngredientsDetails({Key key, @required this.name,  @required this.imageURL}) : super(key : key);
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
        backgroundColor: light,
        title: Text(widget.name, style: TextStyle(color: dark,),),
        elevation: 0,
        
        ),
        backgroundColor: whiteText,//dark,//lightBackground,
        
        
        body: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget> [
                    Container(
                      child: TopBar(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:12.0),
                      width: MediaQuery.of(context).size.width,
                      child: Hero(
                      tag: widget.name,
                      child: Image(image: NetworkImage(widget.imageURL)),),
                    ),
                    if(ingredient!=null)
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0,10.0,8.0,0.0 ),
                      
                      //decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey[600], blurRadius: 10.0,)]),
                      child: FloatingActionButton(
                        elevation: 8,
                        //padding: EdgeInsets.all(12.0),
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(fullscreenDialog: true,
                          builder: (context) => MainScreen(category: widget.name, prefix: 'i',)));
                        },
                        backgroundColor: Color(0xFF43576b),
                        child: Icon(Icons.play_arrow,size: 30,),//Text("View Drinks",style: TextStyle(color: lightBackground),),
                      ),
                    )
                ]
              ),
              
              ingredient == null ? Center(child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(backgroundColor: blackText),
              )) : ingredient == "No Data" ? Center(child: Row(
                children: <Widget>[
                  Image.asset('assets/profiling.png',width: 50, height: 50),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("No Data", style: TextStyle(color: blackText, fontWeight: FontWeight.w600),),)
                ],
              ),)
                 : Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(24.0,40.0,24.0,48.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        DrinkHeader(top: ingredient["strType"], bottom:"Type"),
                        DrinkHeader(top: ingredient["strAlcohol"], bottom:"Alcoholic"),
                        DrinkHeader(top: "${ingredient["strABV"] ?? "-"}", bottom:"% Strength"),
                      ],
                      ),
                      ),
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextWithLine(text: "Summary",color: blackText,),
                       ),
                      Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        ingredient["strDescription"] ?? "No Description",
                        textAlign: TextAlign.justify, 
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[700],//whiteText, 
                          height: 1.5, 
                          letterSpacing: 0.3,
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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:  MainAxisAlignment.center,
      children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(top ?? "-",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: blackText),),
      ),
      Text(bottom, style: TextStyle(color: blackText),),
    ],);
  }
}
