import 'package:flutter/material.dart';
import 'package:ui_practice/networking.dart';
Color light = Color(0xFF2D3446);
Color dark = Color(0xFF202738);
Color lightBackground = Color(0xFFF2F3F4);
Color whiteText = Color(0xFFF9F8F7);
Color g4 = Color(0xFF4A5064);
Color g3 = Color(0xFF464B5F);
Color g2 = Color(0xFF33394B);
Color g1 = Color(0xFF222838);

Future<dynamic> getByCategory(String category, String prefix) async{
  NetworkHelper networkHelper = NetworkHelper("https://www.thecocktaildb.com/api/json/v1/1/filter.php?$prefix=$category");
  var response = await networkHelper.getData();
  return response;
}

Future<dynamic> getIngredientDetails(String name) async{
  NetworkHelper networkHelper = NetworkHelper("https://www.thecocktaildb.com/api/json/v1/1/search.php?i=$name");
  var response = await networkHelper.getIngredientData();
  return response[0];
}


Future<dynamic> getByURL(String url) async{
  NetworkHelper networkHelper = NetworkHelper(url);
  var response = await networkHelper.getData();
  return response[0];
}

Future<dynamic> getDataUsingID(String id) async{
  NetworkHelper networkHelper = NetworkHelper("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id");
  var response = await networkHelper.getData();
  return response[0];
}

Future<dynamic> getList(String url) async{
  NetworkHelper networkHelper = NetworkHelper(url);
  var response = await networkHelper.getData();
  return response;
}

class Details{
  String id,name,tags,category,iba,alcoholic,glass,instructions,image;
    
  Details(String id, String name, String tags, String category, String iba, String alcoholic,
                String glass, String instruction, String imageURL){
      this.id = id;
      this.name = name;
      this.tags = tags;
      this.category = category;
      this.iba = iba;
      this.alcoholic = alcoholic;
      this.glass = glass;
      this.instructions = instruction;
      this.image = imageURL;
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
          child: Image(image: AssetImage('assets/$imgName.png'),
          ),
          width: 25.0,
          height: 25.0,
          margin: EdgeInsets.only(right: 10.0),
          ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Playfair",
              color: whiteText,
              fontSize: 14,
              fontWeight: FontWeight.w500),),
        ),
      ],
    );
  }
}

class TopButtons extends StatelessWidget {
  const TopButtons({
    Key key, @required this.text, this.url, this.image, @required this.myFunction
  }) : super(key: key);

final text, url, image;
final myFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.fromLTRB(0.0,10.0,10.0,10.0),
      decoration: BoxDecoration(
        boxShadow: [new BoxShadow(color: Colors.black26, blurRadius: 10.0)],
        borderRadius: BorderRadius.circular(10.0),
        color: light,
      ),
      child: InkWell(
        onTap: () => myFunction(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                child: Image(
                image: image == null ? url == null ? AssetImage('assets/noimg.jpg') : NetworkImage(url) : AssetImage(image),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "$text",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: whiteText,
                  fontWeight: FontWeight.w500,
                ),),
            ),
          ],
        ),
      ),
        );
  }
}

class TextWithLine extends StatelessWidget {
  const TextWithLine({
    Key key,
    @required this.text, this.fontFamily, this.fontSize, this.color
  }) : super(key: key);

  final String text, fontFamily;
  final fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(text,style: TextStyle(
          color: color ?? whiteText,
          fontWeight: FontWeight.bold,
          fontSize: fontSize ?? 20.0,
          fontFamily: fontFamily ?? "Montserrat",
          ),
          ),
        Flexible(
          flex: 3,
          child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          height: 1.5,
          color: color ?? whiteText,
          ),
        ),
      ],);
  }
}
