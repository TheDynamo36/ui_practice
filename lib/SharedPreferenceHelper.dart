import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class SharedPreferenceHelper{
  SharedPreferences sharedPrefs;
  List<String> bookmarks = [];
  List<String> drinkID = [];

  SharedPreferenceHelper(SharedPreferences preferences){
    this.sharedPrefs = preferences;
  }

  bool checkFavourite(String id){
    drinkID  = getDrinkIdList();
    if(drinkID == null)
    return false;
    return drinkID.contains(id) ? true : false;
  }

  
   getDrinkIdList(){
    drinkID = sharedPrefs.getStringList("id");
    if(drinkID == null)
    drinkID = [];
    return drinkID;
  }

  getBookmarksList(){
    bookmarks = sharedPrefs.getStringList("bookmarks");
    if(bookmarks == null)
    bookmarks = [];
    return bookmarks;
  }

  getBookmarks(){
    List<Map> newList = []; 
    List list = getBookmarksList();
    for(int i = 0 ; i < list.length; i++){
      var temp = json.decode(list[i]);
      print(temp["drink"]);
      newList.add(temp["drink"]);
    }
    return newList;
  }

  removeData(String id){
    Map newMap;
    bookmarks = getBookmarksList() == null ? [] : getBookmarksList();
    drinkID = getDrinkIdList() == null ? [] : getDrinkIdList();
    for(int i = 0 ; i < bookmarks.length ; i++){
      var temp = json.decode(bookmarks[i]);
      newMap = temp["drink"];
      if(newMap['id'] == id){
        bookmarks.removeAt(i);
        drinkID.removeAt(i);
        sharedPrefs.setStringList("bookmarks", bookmarks);
        sharedPrefs.setStringList("id", drinkID);
        print(bookmarks);
        break;
      }
    }
  }

  setData(var response){
    // Map<String,dynamic> newMap = {
    //   'url' : response['strDrinkThumb'],
    //   'title' : response['strDrink'],
    //   'category' : response['strCategory'],
    //   'alcoholic' : response['strAlcoholic'],
    //   'id' : response['idDrink'],
    //   'response' : response,
    //   };
    var resBody = {};
    resBody['url'] = response["strDrinkThumb"];
    resBody['title'] = response["strDrink"];
    resBody['category'] = response["strCategory"];
    resBody['alcoholic'] = response["strAlcoholic"];
    resBody['id'] = response["idDrink"];
    resBody['response'] = response;

    var drink = {};
    drink["drink"] = resBody;
    var value = json.encode(drink);
    bookmarks = getBookmarksList();
    bookmarks.add(value);
    drinkID = getDrinkIdList();
    drinkID.add(response['idDrink']);
    sharedPrefs.setStringList("bookmarks", bookmarks);
    sharedPrefs.setStringList("id", drinkID);
    print(drinkID);
    print(bookmarks);
  }
}