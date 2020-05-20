import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ui_practice/IngredientsDetails.dart';
import 'CustomColors.dart';

class AllIngredients extends StatefulWidget {
  @override
  _AllIngredientsState createState() => _AllIngredientsState();
}

class _AllIngredientsState extends State<AllIngredients> {
  
  var imageURL = "https://www.thecocktaildb.com/images/ingredients/";
  bool _load = false;
  int key = 600;

  showImage(String ingredient){
    if(ingredient == "Absolute Vodka" || ingredient == "Midori"){
      return Image(image: AssetImage('assets/noimg.jpg'));
    }else{
      var image = NetworkImage("$imageURL$ingredient-Small.png");
    return (Image(image:image));
    }
  }
  // fetch() async{
  // //  SharedPreferences prefs = await SharedPreferences.getInstance();
  //   for(int i = 600 ; i <= 700 ; i++){
  //     response = await http.get("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=$i");
  //     var middleResponse = jsonDecode(response.body)['ingredients'];
  //     if(middleResponse == null){
  //     continue;
  //     }
  //     else{
  //     ingredientsList.add(middleResponse[0]['strIngredient']);
  //     print(i);
  //     }
  //   }
  //   //await prefs.setStringList("ingredientsList", ingredientsList);
  //   print(ingredientsList);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(leading:new IconButton(
                icon: new Icon(Icons.arrow_back, color: whiteText,),
                onPressed: (){Navigator.pop(context,true);}
                ),
                backgroundColor: light, title: Text("Ingredients"),
              ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select and Ingredient to view it's details and drinks that can be prepared with it.",
                   style: TextStyle(color: blackText, fontSize: 16.0, fontWeight: FontWeight.w500),
                   maxLines: 3,),
              ),
            ),
            Expanded(
              flex: 8,
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.45),
                              ),
                            itemCount: all_ingredients.length,
                            itemBuilder: (context,index){
                              
                              return (_load && key == index) ? SizedBox(height: 1,)
                              :  Container(
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  boxShadow: [new BoxShadow(color: Colors.black45, blurRadius: 4.0)],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),  
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Flexible(
                                          flex: 9,
                                          child:showImage(all_ingredients[index].trim())),
                                          SizedBox(height: 4.0,),
                                        AutoSizeText(
                                          all_ingredients[index],
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          minFontSize: 10,
                                          maxFontSize: 12,
                                          softWrap: true,
                                          style: TextStyle(color: blackText, fontWeight: FontWeight.w500),),
                                      ],
                                        ),
                                      onTap: (){
                                        setState(() {
                                          _load = true;
                                          key = index;
                                        });
                                       openDetails(all_ingredients[index].trim(),"$imageURL${all_ingredients[index].trim()}.png");
                                        },),
                                  ),
                                ),
                                );
                            }),
            ),
          ],
        ),
      ),
    );
  }

  openDetails(String name, String imageURL) async{
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => IngredientsDetails(name: name, imageURL: imageURL)));
    if(result == true || result == null){
        setState(() {
          _load = false;
          key = 600;
        });
    }
  }
}