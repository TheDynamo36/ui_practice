import 'package:flutter/material.dart';
import 'package:ui_practice/HelperClass/CustomColors.dart';
import 'DrinkDetailsDark.dart';
import 'package:ui_practice/HelperClass/APIHelper.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            appBar: AppBar(leading:new IconButton(
                    icon: new Icon(Icons.arrow_back),
                    onPressed: (){Navigator.pop(context,true);}
                 ),
            backgroundColor: light,
            title: Text(widget.category),
            elevation: 0,
            
            ),
            backgroundColor: lightBackground,
            
            
            body: drinks != null ? 
            drinks == "No Data" ? 
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/profiling.png"),
                  SizedBox(height: 30,),
                  Text("No Data",style: TextStyle(color: blackText, fontSize: 16.0, fontWeight: FontWeight.w600),),
                ],
              )) : 
            ListView.builder(
            itemCount: drinks.length,
            itemBuilder: (context, index){
            return _customListTile(index);
          },
        ) : Center(child: CircularProgressIndicator(backgroundColor: blackText,),),
      ),
    );
  }

Widget _customListTile(int index){
  return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical:10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [new BoxShadow(color: Colors.black54, blurRadius: 4.0)],
                  borderRadius: BorderRadius.circular(10.0)),
                child: _customTile(index),
              )
            );
}

Widget _customTile(int index){
  return ListTile(
                title: Text("${drinks[index]["strDrink"]}",style: TextStyle(color: blackText, fontSize: 20.0)),
                leading: Image(image: NetworkImage("${drinks[index]["strDrinkThumb"]}/preview") ?? AssetImage("assets/noimg.jpg"),),
                trailing: Icon(Icons.navigate_next),
                onTap: (){
                    var data = drinks[index];
                    showDetails(data["idDrink"]);
                  },
        );
}


showDetails(String id){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrinkDetailsDark(id: id),
        fullscreenDialog: true,
      )
    );
  }

}
