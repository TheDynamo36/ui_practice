import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper{

  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    try {
      http.Response response = await http.get(url);
      if(response.statusCode == 200){
        return jsonDecode(response.body)['drinks'];
      }else{print(response.statusCode);}
    }catch(e){print(e);}
  }

  Future getIngredientData() async {
    try {
      http.Response response = await http.get(url);
      if(response.statusCode == 200){
        return jsonDecode(response.body)['ingredients'];
      }else{print(response.statusCode);}
    }catch(e){print(e);}
  }


}
