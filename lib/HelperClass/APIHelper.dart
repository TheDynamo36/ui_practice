import 'package:ui_practice/HelperClass/networking.dart';

Future<dynamic> getByCategory(String category, String prefix) async{
  NetworkHelper networkHelper = NetworkHelper("https://www.thecocktaildb.com/api/json/v1/1/filter.php?$prefix=$category");
  var response = await networkHelper.getData();
  return response;
}

Future<dynamic> getIngredientDetails(String name) async{
  NetworkHelper networkHelper = NetworkHelper("https://www.thecocktaildb.com/api/json/v1/1/search.php?i=$name");
  var response = await networkHelper.getIngredientData();
  return response != null ? response[0] : "No Data";
}


Future<dynamic> getRandomCocktail(String url) async{
  NetworkHelper networkHelper = NetworkHelper(url);
  var response = await networkHelper.getData();
  return response[0];
}

Future<dynamic> getDataUsingID(String id) async{
  NetworkHelper networkHelper = NetworkHelper("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id");
  var response = await networkHelper.getData();
  return response[0];
}

Future<dynamic> getCategoryList(String url) async{
  NetworkHelper networkHelper = NetworkHelper(url);
  var response = await networkHelper.getData();
  return response;
}
