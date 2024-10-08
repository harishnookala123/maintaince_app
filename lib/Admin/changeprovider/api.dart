import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:maintaince_app/Admin/Model/apartmentdetails.dart';
import '../../User/Model/maintaince_bill.dart';
import '../Model/adminRegistartion.dart';
import '../Model/bills.dart';
import '../Model/coadmin.dart';
import '../Model/complaints.dart';
import '../Model/expenserequest.dart';
import '../Model/usermodel.dart';
import '../Model/blocks.dart';
import 'package:path/path.dart';

const String baseUrl = 'http://maintenance-application.ap-south-1.elasticbeanstalk.com';
String baseUrl1 = 'http://192.168.29.92:3000';

class ApiService {
  var dio = Dio();
  Future<Admin?> getAdminById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/admin/$id'));
    if (response.statusCode == 200) {
      var value = Admin.fromJson(json.decode(response.body));
      return value;
    } else {
      return null;
    }
  }
  Future<Admin?>coAdminById (String id) async {
    final response = await http.get(Uri.parse('$baseUrl/co-admin/$id'));
    if (response.statusCode==200){
      print(response.body);
      var value = Admin.fromJson(json.decode(response.body));
      return value;
  }
    return null;
    }
  Future<List<ApartmentDetails>?> getApartmentDetails(String? apartmentCode) async {
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
    var listofusers = [];
    for(int i=0;i<users!.length;i++){
      listofusers.add(users[i].uid);
    }
    final response = await dio.get(
      "$baseUrl/runeverymonth",
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

 Future<List<ExpenseRequest>?> getExpenseusers(String? block_name,
     String? apartment_code,String?status) async {
    var dio = Dio();
    final response = await dio.get('$baseUrl/expenseusers/$apartment_code/$block_name/$status',
        data: {"apartment_code" : apartment_code, "status":status,"block_name":block_name}
    );
    if(response.statusCode==200){
      print(response.data);
      List status = response.data['expenses'];
      return status.map((e) => ExpenseRequest.fromJson(e)).toList();
    }
    return null;
  }
  Future<List<CoAdmin>>fetchCoAdmins(String apartment_code, String userid) async {
    var dio = Dio();
    final response = await dio.get('$baseUrl/co_admin/$apartment_code/$userid');

    if (response.statusCode == 200) {
      List data = response.data["status"];
      print(data);
      var value = data.map((e) => CoAdmin.fromJson(e)).toList();
      return value;
    } else {
      throw Exception('Failed to load CoAdmin list');
    }
  }
   approvalExpenses(String apartmentCode, int id, String status, String remarks) async {
    print(id);
    print(status);
    print(remarks);
    var dio = Dio();

    try {
      final response = await dio.put(
        '$baseUrl/approvalexpenses/$id',
        data: {'status': status,'remarks': remarks},

      );

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
      } else {
        print('Error: Unexpected status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Status: ${e.response?.statusCode}, Data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
  }
  Future<MaintainceBill?>getMaintainceBill(String?userid, String status) async {
    var dio = Dio();
    final response = await dio.get(
        '$baseUrl/maintaincebill/$userid/$status');
    if(response.statusCode==200){
      return MaintainceBill.fromJson(response.data);
    }
    return null;
  }

  Future<List<Complaints>> getComplaint( String apartmentCode,String status) async {
    var dio = Dio();
    try {
      final response = await dio.get('$baseUrl/getComplaints/$apartmentCode/$status');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['results'];
        return data.map((json) => Complaints.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load complaints');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load complaints');
    }
  }


   approveComplaint(int id, String status) async {
    final dio = Dio();
    final String url = '$baseUrl/approvecomplaint/$id/$status';
    print(id);
    try {
      final response = await dio.put(url);
      if (response.statusCode == 200) {
        print('Complaint updated successfully: ${response.data}');
      } else {
        print('Failed to update complaint: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<CoAdmin>?> getCoadminById (String?apartment_code) async {
    var dio = Dio();
    final response = await dio.get('$baseUrl/co_admin/$apartment_code');
    if (response.statusCode == 200) {
     List data = response.data["status"];

     var value = data.map((e) => CoAdmin.fromJson(e)).toList();
     return value;
    } else {
      return null;
    }
  }

  statusUpdate(String? user_id, String status) async {
    var dio = Dio();
    final response = await dio.put('$baseUrl/updatemaintaince/$user_id/$status');
    if (response.statusCode == 200) {
      var data = response.data["records"];
      return MaintainceBill.fromJson(data);

    }
  }

  setDefaultmaintainceAmount(Map<String,dynamic>data) async {
    var dio = Dio();
    var response = await dio.post("$baseUrl/setmaintaincebill",
        data: data
    );

    if(response.statusCode==200){
      print(response.data);
    }
  }
  Future<Bills?> getDefaultAmount(String? apartmentCode) async {
    var dio = Dio();

      // Make sure to use Uri.encodeComponent to handle special characters in the URL
      var response = await dio.get(
          "$baseUrl/getmaintaincebill/$apartmentCode");

    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (data == null || data.isEmpty) {
        return null;
      } else {
        return Bills.fromJson(data);
      }
    }
    return null;


  }
  uploadImage(File imageFile) async {
    Dio dio = Dio();

    String fileName = basename(imageFile.path);
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(imageFile.path, filename: fileName),
    });
    try {
      Response response = await dio.post(
          '$baseUrl/upload', data: formData);
      if (response.statusCode == 200) {
        print('Image uploaded successfully: ${response.data['url']}');
      } else {
        print('Image upload failed: ${response.statusMessage}');
      }
    }catch(e){

    }

  }

  postExpenses(String? userid, File? image, Map<String, String?> data) async {
    try {
      FormData formData = FormData.fromMap({
        'data': data,
        if (image != null) 'image': await MultipartFile.fromFile(image.path),
      });

      Response response = await Dio().post(
        '$baseUrl/expenses/$userid',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response.data["message"];
    } catch (e) {
      print('Error: $e');
    }
  }

  postComplaint(Map<String, String?> data, File? image) async {
    try {
      FormData formData = FormData.fromMap({
        'data': data,
        if (image != null) 'image': await MultipartFile.fromFile(image.path),
      });

      Response response = await Dio().post(
        '$baseUrl/complaint',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      print(response.data);
      return response.data["message"];
    } catch (e) {
      print('Error: $e');
    }
  }

  editprofile(Map<String, String?> data, String? id) async {

    Response response = await Dio().put(
      '$baseUrl1/user/$id',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}


