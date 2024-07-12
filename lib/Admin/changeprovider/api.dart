import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:maintaince_app/Admin/Model/apartmentdetails.dart';
import '../Model/adminRegistartion.dart';
import '../Model/usermodel.dart';
import '../Model/blocks.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.29.92:3000';
  var dio = Dio();

  Future<Admin?> getAdminById(String id) async {
    print(id);
    final response = await http.get(Uri.parse('$baseUrl/admin/$id'));
    if (response.statusCode == 200) {
      // print(response.body.toString() + "AdminId");
      // print(response.body);
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
        'http://192.168.29.92:3000/userregister/$apartmentCode',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        List data = response.data["apartmentDetails"];
        print(data);
        return data.map((json) => ApartmentDetails.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }

  Future<List<String>?>getFlats(String? apartmentcode,String?blockname) async {
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();
    try {
      var response = await dio.get(
        'http://192.168.29.92:3000/flats/$apartmentcode/$blockname',
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

  Future<List<Users>?> getUsers(String apartId, String requests, String? selectedvalue) async {
    print("${selectedvalue}Blockname");
    var data = {"apartId": apartId,"blockname":selectedvalue};
    var dio = Dio();
    var response = await dio.request(
      'http://192.168.29.92:3000/user/$apartId/$requests/$selectedvalue',
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
    return null;
  }

   updateApproval(String userId, String approvalStatus, String text) async {
    print(text);
    try {
      final dio = Dio();
      final response = await dio.put(
        'http://192.168.29.92:3000/approval/$userId',
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
  static Future<Users?>userData(String userid) async {
    print(userid);
    final response = await http.get(Uri.parse('$baseUrl/user/$userid'));
    if (response.statusCode == 200) {
      var data  = response.body;
      print(data);
      var value = Users.fromJson(json.decode(response.body));
      return value;
    } else {
      return null;
    }
  }
   fetchAdminData(String id) async {
    final dio = Dio();
    // print(id.toString()+ "dgdg");
    final url = 'http://192.168.29.92:3000/admin/$id'; // Replace with your backend URL
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        print('Admin data: ${response.data}');
        // Handle the data (e.g., parse JSON to Dart object)
      } else {
        print('Failed to load admin data: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  static addingBlocks(String apartname, data) async {
    final Dio dio = Dio();
    final response = await dio.post(
      'http://192.168.29.92:3000/approval/admin/apartments',
      data: data,
    );
    if (response.statusCode == 200) {
      var status = response.data["status"];
      return status;
    }else{

    }
  }

  Future<List<BlockNames>?>getBlocks(String? apartmentCode) async {
    // print(apartmentCode);
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();
    try {
      var response = await dio.get(
        'http://192.168.29.92:3000/userregister/$apartmentCode',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        List data = response.data["blockname"];
        print(data);
        return data.map((json) => BlockNames.fromJson(json)).toList();
      }
    } catch (e) {
       // print("Error: $e");
    }

    return null;
  }

  Future<String?>registerUser(Map<String, dynamic> userData) async {
    var response = await dio.post(
      'http://192.168.29.92:3000/registerUser',
      options: Options(
        method: 'Post',
      ),
      data: userData,
    );
    if(response.statusCode==200){
      print(response.data);
       var userid = response.data["status"];

       return userid;
    }
    return null;
  }
  Future<String?>getapartcode(String?userid) async {
    var userId = {"userid":userid!};
    var response = await dio.get(
      'http://192.168.29.92:3000/apartmentcode/$userid',
      options: Options(
        method: 'GET',
      ),
      data: userId,
    );
   if(response.statusCode==200){
     String apartcode = response.data["apartmentCode"];
     return apartcode;
   }
   return null;
  }


  Future<List<String>?>getBlockName(String? apartid) async {
    var userId = {"apartmentCode":apartid!};
    var response = await dio.get(
      'http://192.168.29.92:3000/blockname/$apartid',
      options: Options(
        method: 'GET',
      ),
      data: userId,
    );
    if(response.statusCode==200){
      List block = response.data["block_name"];
      List<String>blocknames=[];
      for(int i=0;i<block.length;i++){
        blocknames.add(block[i]["block_name"].toString());
      }
      return blocknames;
  }
    return null;
  }
}
