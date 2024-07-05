import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:maintaince_app/Admin/Model/apartmentdetails.dart';
import '../Model/adminRegistartion.dart';
import '../Model/usermodel.dart';
import '../Model/blocks.dart';

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
  Future<List<ApartmentDetails>?> getApartmentDetails(String? apartmentCode) async {
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();

    try {
      var response = await dio.get(
        'http://192.168.29.231:3000/userregister/$apartmentCode',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        List data = response.data["apartmentDetails"];
        return data.map((json) => ApartmentDetails.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }

  Future<List<String>?>getFlats(String? apartmentcode,String?blockname) async {
    print(apartmentcode.toString() + "dgdg");
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();
    try {
      var response = await dio.get(
        'http://192.168.29.231:3000/flats/$apartmentcode/$blockname',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
       List data = response.data;
       List<String> values = [];
        for(int i=0;i<data.length;i++){
          values.add(data[i]['flat_no']);
        }
        return values;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<List<Users>?> getUsers(String apartId, String requests) async {
    var data = {"apartId": apartId};
    var dio = Dio();
    var response = await dio.request(
      'http://192.168.29.231:3000/user/$apartId/$requests',
      options: Options(
        method: 'GET',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      List data = response.data['Users'];
      return data.map((json) => Users.fromJson(json)).toList();
    } else {
      print(response.statusMessage);
    }
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

  Future<List<BlockNames>?> getBlocks(String? apartmentCode) async {
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();

    try {
      var response = await dio.get(
        'http://192.168.29.231:3000/userregister/$apartmentCode',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        List data = response.data["blockname"];
        return data.map((json) => BlockNames.fromJson(json)).toList();
      }
    } catch (e) {
       print("Error: $e");
    }

    return null;
  }
}
