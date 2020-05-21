
import 'package:flutter/material.dart';
import 'package:ui_practice/HelperClass/CustomColors.dart';
import 'package:ui_practice/Screens/MainScreen.dart';
import 'package:ui_practice/Widgets/TextWithLine.dart';
import 'package:ui_practice/HelperClass/CurvePainter.dart';
import 'package:ui_practice/HelperClass/APIHelper.dart';

class IngredientsDetails extends StatefulWidget {
final name;
const IngredientsDetails({Key key, @required this.name}) : super(key : key);
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
    var imageURL = "https://www.thecocktaildb.com/images/ingredients/${widget.name}.png";
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
          appBar: _buildAppBar(context, widget.name),
        backgroundColor: whiteText,
        
        
        body: SingleChildScrollView(
              child: ingredient == null   ?    Center(child: CircularProgressIndicator(backgroundColor: blackText),) 

                  : ingredient == "No Data" ? _noDataImage()

                    : Column(children: <Widget>[
                    // if(ingredient!=null)
                          _customImage(context, imageURL, widget.name),
                          
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0,20.0,12.0,20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                            DrinkHeader(top: ingredient["strType"].trim(), bottom:"Type"),
                                            DrinkHeader(top: ingredient["strAlcohol"], bottom:"Alcoholic"),
                                            DrinkHeader(top: "${ingredient["strABV"] ?? "-"}", bottom:"Strength"),
                                       ],
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*0.045,),
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
                        ],
                    ),
        ) ,
        ),
    );
  }
}

Widget _buildAppBar(BuildContext context, String title){
  return AppBar(leading:new IconButton(
                icon: new Icon(Icons.arrow_back, color: dark,),
                onPressed: (){Navigator.pop(context,true);}
             ),
                backgroundColor: light,
                title: Text(title, style: TextStyle(color: dark,),),
                elevation: 0,
    );
}

Widget _customImage(BuildContext context, String imageURL, String name){
  return Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: <Widget> [
                                Container(
                                  child: TopBar(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top:12.0),
                                  width: MediaQuery.of(context).size.width,
                                  child: Image(image: NetworkImage(imageURL)),
                                ),
                                
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.0,10.0,8.0,0.0 ),
                                  //decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey[600], blurRadius: 10.0,)]),
                                  child: FloatingActionButton(
                                    elevation: 8,
                                    //padding: EdgeInsets.all(12.0),
                                    onPressed: (){
                                      Navigator.push(context,MaterialPageRoute(fullscreenDialog: true,
                                      builder: (context) => MainScreen(category: name, prefix: 'i',)));
                                    },
                                    backgroundColor: Color(0xFF43576b),
                                    child: Icon(Icons.play_arrow,size: 30,),//Text("View Drinks",style: TextStyle(color: lightBackground),),
                                  ),
                                )
                            ]
                          );
}

Widget _noDataImage(){
  return Center(child: Row(
                  children: <Widget>[
                    Image.asset('assets/profiling.png',width: 50, height: 50),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("No Data", style: TextStyle(color: blackText, fontWeight: FontWeight.w600),
                             ),
                    ),
                  ],
                ),
  );
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
        child: Text(top ?? "-",style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: blackText),),
      ),
      Text(bottom, style: TextStyle(color: blackText),),
    ],);
  }
}
