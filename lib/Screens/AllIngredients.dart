import 'package:flutter/material.dart';
import 'package:ui_practice/Screens/IngredientsDetails.dart';
import 'package:ui_practice/HelperClass/CustomColors.dart';
import 'package:ui_practice/HelperClass/IngredientsList.dart';

class AllIngredients extends StatefulWidget {
  @override
  _AllIngredientsState createState() => new _AllIngredientsState();
}

class _AllIngredientsState extends State<AllIngredients> {
  Widget appBarTitle = new Text(
    "Search Ingredients",
    style: new TextStyle(color: Colors.white),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final imageURL = "https://www.thecocktaildb.com/images/ingredients/";
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List _list = all_ingredients;
  bool _isSearching;
  String _searchText = "";
  List searchresult = new List();

  _AllIngredientsState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _search();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: globalKey,
        appBar: buildAppBar(context),
        body: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Flexible(
                  child: searchresult.length != 0 || _controller.text.isNotEmpty
                      ? new GridView.builder(
                          shrinkWrap: true,
                          itemCount: searchresult.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            String listData = searchresult[index].trim();
                            return _customCard(context, listData);
                          },
                        )
                      : new ListView.builder(
                          shrinkWrap: true,
                          itemCount: _list.length,
                          itemBuilder: (BuildContext context, int index) {
                            String listData = _list[index].trim();
                            return _customNonSearchCard(listData);
                          },
                        ))
            ],
          ),
        ));
  }



  Widget buildAppBar(BuildContext context) {
    return new AppBar(backgroundColor: light, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {_search();},
      ),
    ]);
  }





  Widget _customCard(BuildContext context, String listData){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => IngredientsDetails(name: listData))),
          child: Card(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    Expanded(child: showImage(listData)),
                    SizedBox(height: 3.0,),
                    Text(listData, style: TextStyle(color: blackText, fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
    );
  }



  Widget _customNonSearchCard(String listData){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => IngredientsDetails(name: listData))),
            child: Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                                leading: Image.network("$imageURL/$listData-Small.png"),
                                title: Text(listData.toString(), style: TextStyle(fontWeight: FontWeight.w500),),
                                trailing: Icon(Icons.navigate_next, color: blackText,),
                              ),
                      ),
              ),
    );
  }




  Widget showImage(String ingredient){
    if(ingredient == "Absolute Vodka" || ingredient == "Midori"){
      return Image.asset('assets/noimg.jpg');
    }else{
    return Image.network("$imageURL$ingredient-Small.png");
    }
  }




  void _search(){
          setState(() {
            if (this.icon.icon == Icons.search) {
              this.icon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _controller,
                cursorColor: whiteText,
                scrollPadding: EdgeInsets.all(10.0),
                autofocus: true,
                style: new TextStyle(
                  color: whiteText,
                ),
                decoration: new InputDecoration(
                    hintText: "Search Ingredient...",
                    hintStyle: new TextStyle(color: whiteText)),
                onChanged: searchOperation,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
  }



  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }



  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search Ingredients",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
      searchresult = [];
    });
  }




  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}