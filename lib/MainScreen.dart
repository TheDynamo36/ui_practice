// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:ui_practice/CustomColors.dart';
//import 'package:ui_practice/DrinkDetail.dart';
import 'DrinkDetailsDark.dart';

class MainScreen extends StatefulWidget {
final category, prefix;
const MainScreen({Key key, @required this.category,  @required this.prefix}) : super(key : key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  var drinks;
  @override 
  void initState(){
    super.initState();
    fetchData();
  }

  fetchData() async{
   drinks = await getByCategory(widget.category, widget.prefix);
   setState(() {});
  }

  showDetails(String id, int index) async{
    var data = await getDataUsingID(id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrinkDetailsDark(response: data),
        fullscreenDialog: true,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            appBar: AppBar(leading:new IconButton(
                    icon: new Icon(Icons.arrow_back),
                    onPressed: (){Navigator.pop(context,true);}
                 ),
            backgroundColor: dark,
            title: Text(widget.category),
            elevation: 0,
            
            ),
            backgroundColor: dark,
            
            
            body: drinks != null ? 
            drinks == "No Data" ? 
            Center(child: Text("No Data",style: TextStyle(color: whiteText),)) : 
            ListView.builder(
            itemCount: drinks.length,
            itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: (){
                     
                    print("Pressed");
                    var data = drinks[index];
                    showDetails(data["idDrink"], index);
                  },
                  child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(color: light,
                  boxShadow: [new BoxShadow(color: Colors.black26, blurRadius: 5.0)],
                  borderRadius: BorderRadius.all(Radius.circular(10),),
                  ),
                  child: Row(
                    children: <Widget>[
                      Hero(
                          tag: drinks[index]["idDrink"],
                          child: ClipRRect(
                          child: Image(image: NetworkImage("${drinks[index]["strDrinkThumb"]}/preview") ?? AssetImage("assets/noimg.jpg"),
                          height: 130,
                          width: 130,),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${drinks[index]["strDrink"]}",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ) : Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
