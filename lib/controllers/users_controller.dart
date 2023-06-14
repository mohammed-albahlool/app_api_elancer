import 'dart:convert';
import 'package:app_api_elancer/api/api_settings.dart';
import 'package:app_api_elancer/model/api_base_response.dart';
import 'package:app_api_elancer/model/categories.dart';
import 'package:app_api_elancer/model/user.dart';
import 'package:http/http.dart' as http ;
class UserApiController{

  Future<List<User>> getUsers() async {
    var url = Uri.parse(ApiSettings.users);
    var response = await http.get(url);

    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      ApiBaseResponse apiBaseResponse = ApiBaseResponse.fromJson(jsonResponse);
      return apiBaseResponse.data; 
    }else {

    }
     return[];
  }

  Future<List<Category>> getCategories() async {
    var url = Uri.parse(ApiSettings.categories);
    var response = await http.get(url);
    if(response.statusCode == 200){
      var categoriesJsonArray = jsonDecode(response.body)['data'] as List;
      return categoriesJsonArray
          .map((jsonObject) => Category.fromJson(jsonObject))
          .toList();

    }
    return[];

  }

}