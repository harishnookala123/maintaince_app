import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:maintaince_app/Admin/Model/apartmentdetails.dart';
import '../Model/adminRegistartion.dart';
import '../Model/coadmin.dart';
import '../Model/expenserequest.dart';
import '../Model/usermodel.dart';
import '../Model/blocks.dart';
 const String baseUrl = 'http://maintenanceapplication.ap-south-1.elasticbeanstalk.com';

class ApiService {
  var dio = Dio();
   String baseUrl1 = 'http://192.168.1.7:3000';
  Future<Admin?> getAdminById(String id) async {
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
        '$baseUrl1/userregister/$apartmentCode',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data["apartmentDetails"];
        return data.map((json) => ApartmentDetails.fromJson(json)).toList();
      }
    } catch (e) {
      print("dgd");
    }

    return null;
  }

  Future<List<String>?>getFlats(String? apartmentcode,String?blockname) async {
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();
    try {
      var response = await dio.get(
        '$baseUrl/flats/$apartmentcode/$blockname',
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
    }
    return null;
  }

  Future<List<Users>?> getUsers(String apartId, String requests, String? selectedvalue) async {
    var data = {"apartId": apartId,"blockname":selectedvalue};
    var dio = Dio();
    var response = await dio.request(
      '$baseUrl/user/$apartId/$requests/$selectedvalue',
      options: Options(
        method: 'GET',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      List data = response.data['Users'];
      return data.map((json) => Users.fromJson(json)).toList();
    } else {
    }
    return null;
  }

   updateApproval(String userId, String approvalStatus, String text) async {
    try {
      final dio = Dio();
      final response = await dio.put(
        '$baseUrl/approval/$userId',
        data: {'status': approvalStatus,'remarks': text},
      );
      if (response.statusCode == 200) {
      } else {
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  static Future<Users?>userData(String userid) async {
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
    print(id.toString()+ "dgdg");
    final url = '$baseUrl/admin/$id'; // Replace with your backend URL
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
      '$baseUrl/approval/admin/apartments',
      data: data,
    );
    if (response.statusCode == 200) {
      var status = response.data["status"];
      return status;
    }else{

    }
  }

  Future<List<BlockNames>?>getBlocks(String? apartmentCode) async {
    print(apartmentCode);
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();
    try {
      var response = await dio.get(
        '$baseUrl/userregister/$apartmentCode',
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
       print("Error: $e");
    }

    return null;
  }

  Future<String?>registerUser(Map<String, dynamic> userData) async {
    print(userData);
    var response = await dio.post(
      '$baseUrl/registerUser',
      options: Options(
        method: 'Post',
      ),
      data: userData,
    );
    if(response.statusCode==200){
       var userid = response.data["status"];

       return userid;
    }
    return null;
  }
  Future<String?>getapartcode(String?userid) async {
    var userId = {"userid":userid!};
    var response = await dio.get(
      '$baseUrl/apartmentcode/$userid',
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
      '$baseUrl/blockname/$apartid',
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
  maintainceAmount(Map<String,dynamic>data, String? blockname, String? apartcode) async {
    var users = await getUsers(apartcode!, "Approved", blockname);
   var listofusers= [];
    for(int i=0;i<users!.length;i++){
      listofusers.add(users[i].uid);
    }
    print(listofusers);
    final response = await dio.post(
      '$baseUrl/adminmaintaince/$blockname',
      data: {"data":data,"userid":listofusers},
    );
    if (response.statusCode == 200) {
      print(response.data);
      var status = response.data["status"];

      return status;
    }
  }

   postexpenses(String? uid, Map<String, dynamic> data) async {
    print(data);
    var dio = Dio();
    final response = await dio.post(
      '$baseUrl/expenses/$uid',
      data: {"data":data,"userid":uid},
    );
     if(response.statusCode==200){
       var status = response.data["status"];
       return status;
     }
   }

 Future<List<ExpenseRequest>?> getExpenseusers(String? block_name, String? apartment_code,String?status) async {
    var dio = Dio();
    final response = await dio.get('$baseUrl1/expenseusers/$apartment_code/$block_name/$status',
        data: {"apartment_code" : apartment_code, "status":status,"block_name":block_name}
    );
    if(response.statusCode==200){
      print(response.data);
      List status = response.data['expenses'];
      return status.map((e) => ExpenseRequest.fromJson(e)).toList();
    }
  }
  Future<List<CoAdmin>>fetchCoAdmins(String apartment_code, String userid) async {
    var dio = Dio();
    final response = await dio.get('$baseUrl1/co_admin/$apartment_code/$userid');

    if (response.statusCode == 200) {
      List data = response.data["status"];
      print(data);
      var value = data.map((e) => CoAdmin.fromJson(e)).toList();
      return value;
    } else {
      throw Exception('Failed to load CoAdmin list');
    }
  }


}
