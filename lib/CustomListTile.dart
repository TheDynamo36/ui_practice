import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.thumbnail,
    this.title,
    this.category,
    this.alcoholic,
    this.onPressed,
  });

  final Widget thumbnail;
  final String title;
  final String category;
  final String alcoholic;
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
        margin: EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: thumbnail,
            ),
            Expanded(
              flex: 3,
              child: _DrinkDescription(
                title: title,
                category: category,
                alcoholic: alcoholic,
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
    this.title,
    this.category,
    this.alcoholic,
  }) : super(key: key);

  final String title;
  final String category;
  final String alcoholic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            "$category | $alcoholic",
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
          ),
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