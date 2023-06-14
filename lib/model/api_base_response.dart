import 'package:app_api_elancer/model/user.dart';

class ApiBaseResponse {
  late bool status;
  late String message;
  late List<User> data;


  ApiBaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(User.fromJson(v));
      });
    }
  }

}