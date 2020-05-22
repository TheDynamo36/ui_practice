import 'package:flutter/material.dart';
import 'package:ui_practice/Screens/IngredientsDetails.dart';
import 'package:ui_practice/HelperClass/CustomColors.dart';
import 'package:ui_practice/HelperClass/SharedPreferenceHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/Widgets/RowText.dart';
import 'package:ui_practice/Widgets/TextWithLine.dart';
import 'package:ui_practice/HelperClass/APIHelper.dart';

class DrinkDetailsDark extends StatefulWidget {
  final id, directResponse;

  const DrinkDetailsDark({Key key, this.id, this.directResponse})
      : super(key: key);

  @override
  _DrinkDetailsDarkState createState() => _DrinkDetailsDarkState();
}

class _DrinkDetailsDarkState extends State<DrinkDetailsDark> {
  var response;
  var ingredientsList = [];
  var measurementList = [];
  var _favourite = false;
  Color ourBlack = Color(0xFF121619);
  SharedPreferences preference;
  SharedPreferenceHelper prefs;
  @override
  void initState() {
    super.initState();
    if (widget.directResponse == null) {
      getResponse();
    } else {
      response = widget.directResponse;
      setState(() {
        updateUI();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: lightBackground,
          body: response == null
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: blackText,
                ))
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Main Beverage Image

                      Stack(children: <Widget>[
                        _image(),
                        _customIcons(),
                      ]),

                      SizedBox(height: 8.0),

                      //Beverage Title

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          response['strDrink'],
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: blackText,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //Alcoholic...... ??

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            "${response['strAlcoholic'] ?? "Unidentified"}",
                            style: TextStyle(color: blackText),
                        ),
                      ),

                      //Category
                      //Comment
                      //Glass

                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
                        child: Column(
                          children: <Widget>[
                            RowText(
                                text: "${response['strCategory']}",
                                imgName: "categoryblack"),
                            RowText(
                                text: "${response['strTags'] ?? "No Comments"}",
                                imgName: "commentcolor",
                            ),
                            RowText(
                                text: "${response['strGlass'].toString().length < 4 ? "-" : response['strGlass']}",
                                imgName: "glassred"),
                          ],
                        ),
                      ),

                      //Ingredients

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWithLine(
                          text: "Ingredients",
                          color: blackText,
                        ),
                      ),
                      SizedBox(height: 10.0),

                      Container(
                        width: double.maxFinite,
                        height: size.height > 680
                            ? 165
                            : (size.height * 24.5 / 100),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: ingredientsList.length,
                            itemBuilder: (context, index) {
                              return _customCard(index, size);
                            }),
                      ),

                      SizedBox(height: 10.0),

                      //Instructions

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWithLine(
                          text: "Instructions",
                          color: blackText,
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 24.0),
                        child: Text(
                          response['strInstructions'].toString(),
                          style: TextStyle(
                              color: blackText,
                              height: 1.7,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void updateUI() {
    setState(() {
      for (int i = 1; i <= 15; i++) {
        if (this.response['strIngredient$i'] == null ||
            this.response['strIngredient$i'].toString().length < 3) break;
        ingredientsList.add(this.response['strIngredient$i']);
        measurementList.add(this.response['strMeasure$i'] ?? "-");
      }
    });
    getSahredPreferences();
  }

  getSahredPreferences() async {
    preference = await SharedPreferences.getInstance();
    prefs = new SharedPreferenceHelper(preference);
    prefs.checkFavourite(response['idDrink'])
        ? setState(() {
            _favourite = true;
          })
        : setState(() {
            _favourite = false;
          });
  }

  getResponse() async {
    response = await getDataUsingID(widget.id);
    setState(() {
      updateUI();
    });
  }

  toggleBookmark() {
    if (!_favourite) {
      prefs.setData(response);
      setState(() {
        _favourite = true;
      });
    } else {
      prefs.removeData(response['idDrink']);
      setState(() {
        _favourite = false;
      });
    }
  }

  Widget _customCard(int index, var size) {
    return InkWell(
      onTap: () {
        openDetails(ingredientsList[index]);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)],
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF45536D),
        ),
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Image.network(
                "https://www.thecocktaildb.com/images/ingredients/${ingredientsList[index].trim()}-Medium.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              "${measurementList[index]}",
              maxLines: 2,
              style: TextStyle(
                  fontSize: 16, color: whiteText, fontWeight: FontWeight.w500),
            ),
            Text(
              "${ingredientsList[index]}",
              maxLines: 2,
              style: TextStyle(
                  fontSize: 12, color: whiteText, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  _image() {
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
        child: Image(
          image: NetworkImage("${response['strDrinkThumb']}") ??
              AssetImage("assets/noimg.jpg"),
        ),
      ),
    );
  }

  _customIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            new BoxShadow(color: Colors.black26, blurRadius: 22.0)
          ]),
          child: IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            new BoxShadow(color: Colors.black26, blurRadius: 22.0)
          ]),
          child: IconButton(
            iconSize: 30.0,
            icon: Icon(_favourite ? Icons.favorite : Icons.favorite_border,
                color: _favourite ? Colors.red : Colors.white),
            onPressed: () {
              toggleBookmark();
            },
          ),
        ),
      ],
    );
  }

  openDetails(String ingredient) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => IngredientsDetails(name: ingredient)));
  }
}
