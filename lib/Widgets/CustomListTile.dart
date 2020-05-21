import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.thumbnail,
    this.onPressed,
    this.drink,
  });

  final Map drink;
  final Widget thumbnail;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){onPressed();},
          child: Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [new BoxShadow(color: Colors.black45, blurRadius: 8.0)]
        ),
        margin: EdgeInsets.only(top: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: thumbnail,
            ),
            Expanded(
              flex: 4,
              child: _DrinkDescription(
                drink: drink,
              ),
            ),
            const Icon(
              Icons.navigate_next,
              size: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrinkDescription extends StatelessWidget {
  const _DrinkDescription({
    Key key,
    this.drink,
  }) : super(key: key);

  final Map drink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            drink['strDrink'],
            minFontSize: 16.0,
            maxLines: 3,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.0
            ),
          ),
          
          Text(
            "${drink['strCategory']} | ${drink['strAlcoholic']}",
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
          ),

          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),

          Text("Ingredients", style: TextStyle(fontWeight: FontWeight.w500, decoration: TextDecoration.underline,),),
          
          for(int i = 1 ; i <= 3 ; i++)
          if(drink['strIngredient$i'] != null)
           Text("- ${drink['strIngredient$i']}", style: TextStyle(fontSize: 12.0),),
        ],
      ),
    );
  }
}

// // ...

// Widget build(BuildContext context) {
//   return ListView(
//     padding: const EdgeInsets.all(8.0),
//     itemExtent: 106.0,
//     children: <CustomListItem>[
//       CustomListItem(
//         user: 'Flutter',
//         viewCount: 999000,
//         thumbnail: Container(
//           decoration: const BoxDecoration(color: Colors.blue),
//         ),
//         title: 'The Flutter YouTube Channel',
//       ),
//       CustomListItem(
//         user: 'Dash',
//         viewCount: 884000,
//         thumbnail: Container(
//           decoration: const BoxDecoration(color: Colors.yellow),
//         ),
//         title: 'Announcing Flutter 1.0',
//       ),
//     ],
//   );
// }