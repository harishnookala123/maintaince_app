import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:maintaince_app/Admin/Views/registration.dart';

import '../Model/adminRegistartion.dart';
import '../Model/usermodel.dart';
class ApiService {
  static const String baseUrl = 'http://192.168.29.231:3000';

  Future<Admin?> getUserById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/admin/$id'));

    if (response.statusCode == 200) {
      var value = Admin.fromJson(json.decode(response.body));
       return value;
    } else {
      return null;
    }
  }
  Future<List<Users>?>getUsers(String apartId) async{
    var data  = {"apartId":apartId};
    var dio = Dio();
    var response = await dio.request(
      'http://192.168.29.231:3000/user/$apartId',
      options: Options(
        method: 'GET',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      List  data = response.data['Users'];
      return data.map((json) => Users.fromJson(json)).toList();
    }
    else {
      print(response.statusMessage);
    }
    return null;
  }
}