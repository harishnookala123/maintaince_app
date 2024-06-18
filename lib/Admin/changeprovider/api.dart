import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maintaince_app/Admin/Views/registration.dart';

import '../Model/adminRegistartion.dart';
class ApiService {
  static const String baseUrl = 'http://192.168.29.231:3000';

  Future<Admin?> getUserById(String id) async {
    print(id);
    final response = await http.get(Uri.parse('$baseUrl/admin/$id'));

    if (response.statusCode == 200) {

      var value = Admin.fromJson(json.decode(response.body));
       return value;
    } else {
      return null;
    }
  }
}