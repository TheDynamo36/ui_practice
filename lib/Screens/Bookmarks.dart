import 'package:flutter/material.dart';
import 'package:ui_practice/Screens/DrinkDetailsDark.dart';
import 'package:ui_practice/HelperClass/SharedPreferenceHelper.dart';
import 'package:ui_practice/HelperClass/CustomColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/Widgets/CustomListTile.dart';

class Bookmarks extends StatefulWidget {

  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {

var bookmarks = [];
SharedPreferences prefs;
SharedPreferenceHelper sharedPrefsHelper;
Map<String,dynamic> newMap;

  @override
  void initState(){
    super.initState();
    getSharedPreferences();
}

getSharedPreferences() async{
  prefs = await SharedPreferences.getInstance();
  sharedPrefsHelper = new SharedPreferenceHelper(prefs);
  setState((){bookmarks = sharedPrefsHelper.getBookmarks();});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: light,
        title: Text("Bookmarks"),),
      body: bookmarks == null ? Center(child: Text("No Data", style: TextStyle(color: blackText),)) :
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index){
                return CustomListItem(
                  onPressed: () => {openDetails(index)},
                  drink: bookmarks[index]['response'],
                  thumbnail: ClipRRect(borderRadius: BorderRadius.circular(10.0),child: Image.network(bookmarks[index]["url"])),
                );
                }
              ),
        ),
    );
  }


  openDetails(int index) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>DrinkDetailsDark(directResponse: bookmarks[index]['response'],)));
    if(result == true || result == null){
      setState(() {
         bookmarks = sharedPrefsHelper.getBookmarks();
        });
    }
  }

  
}