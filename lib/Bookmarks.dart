import 'package:flutter/material.dart';
import 'package:ui_practice/DrinkDetailsDark.dart';
import 'package:ui_practice/SharedPreferenceHelper.dart';
import 'CustomColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CustomListTile.dart';

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
      backgroundColor: dark,
      appBar: AppBar(backgroundColor: light,
      title: Text("Bookmarks"),),
      body: bookmarks == null ? Center(child: Text("No Data")) :
      ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index){
             return CustomListItem(
               onPressed: () => {openDetails(index)},
               thumbnail: ClipRRect(borderRadius: BorderRadius.circular(10.0),child: Image.network(bookmarks[index]["url"])),
               title: bookmarks[index]["title"],
               category: bookmarks[index]["category"],
               alcoholic: bookmarks[index]["alcoholic"],
             );

          // newMap = json.decode(bookmarks[index]);
          // return Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: FlatButton(
          //         onPressed: (){
                    
          //         },
          //         child: Container(
          //         padding: const EdgeInsets.all(12.0),
          //         decoration: BoxDecoration(color: light,
          //         boxShadow: [new BoxShadow(color: Colors.black26, blurRadius: 5.0)],
          //         borderRadius: BorderRadius.all(Radius.circular(10),),
          //         ),
          //         child: Row(
          //           children: <Widget>[
          //             Hero(
          //                 tag: bookmarks[index]["id"],
          //                 child: ClipRRect(
          //                 child: Image(
          //                   image: NetworkImage("${bookmarks[index]['url']}/preview" ?? AssetImage("assets/noimg.jpg"),),
          //                   fit: BoxFit.contain,
          //                 height: 130,
          //                 width: 130,),
          //                 borderRadius: BorderRadius.all(Radius.circular(10)),
          //               ),
          //             ),
          //             SizedBox(width: 20),
          //             Column(
                        
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   width: 120,
          //                   child: AutoSizeText(
          //                     "${bookmarks[index]['name']}",
          //                     maxLines: 3,
          //                     minFontSize: 16,
          //                     maxFontSize: 20,
          //                     softWrap: true,
          //                     overflow: TextOverflow.ellipsis,
          //                     style: TextStyle(
          //                       color: Colors.white70,
          //                       fontWeight: FontWeight.bold,
          //                       ),
          //                       ),
          //                 ),
          //                 SizedBox(height: 10,),
          //                 Text(
          //                   "${bookmarks[index]['category']}",
          //                   style: TextStyle(color: Colors.white70),
          //                 )
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          // );
            }
          ),
    );
  }
  openDetails(int index) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>DrinkDetailsDark(response: bookmarks[index]['response'],)));
    if(result == true || result == null){
      setState(() {
         bookmarks = sharedPrefsHelper.getBookmarks();
        });
    }
  }

  // getBookmarks() async{
  //   var prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     bookmarks = prefs.getStringList("favDrinks");
  //     print(bookmarks);
  //   });
  // }
}