import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../Model/adminRegistartion.dart';
import '../Model/usermodel.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.6:3000';

  Future<Admin?> getUserById(String id) async {
    var dio = Dio();
    final response = await http.get(Uri.parse('$baseUrl/admin/$id'));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      var value = Admin.fromJson(json.decode(response.body));
      return value;
    } else {
      return null;
    }
  }

  Future<List<Users>?> getUsers(String apartId, String requests) async {
    var data = {"apartId": apartId};
    var dio = Dio();
    var response = await dio.request(
      'http://192.168.1.6:3000/user/$apartId/$requests',
      options: Options(
        method: 'GET',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      List data = response.data['Users'];
      print(data);
      return data.map((json) => Users.fromJson(json)).toList();
    } else {
      print(response.statusMessage);
    }
    return null;
  }

   updateApproval(int userId, String approvalStatus, String text) async {
    print(text);
    try {
      final dio = Dio();
      final response = await dio.put(
        'http://192.168.1.6:3000/approval/$userId',
        data: {'approval': approvalStatus,'remarks': text},
      );

      if (response.statusCode == 200) {
        print('Approval status updated successfully');
      } else {
        print('Failed to update approval status');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  static  userData(int userid) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userid'));
    if (response.statusCode == 200) {
      var value =  Users.fromJson(json.decode(response.body));
      return value;
    } else {
      return null;
    }
  }
  static addingBlocks(String apartname, data) async {
    final Dio dio = Dio();
    final response = await dio.post(
      'http://192.168.29.231:3000/approval/admin/apartments',
      data: data,
    );
    if (response.statusCode == 200) {
      var status = response.data["status"];
      return status;
    }else{

    }
  }
}
