import 'package:flutter/cupertino.dart';

class Userregistration extends ChangeNotifier{
  String?_first_name;
  String?_last_name;
  String? _uid;
  String?_email;

  String? get first_name => _first_name;

  setfirst_name(String value) {
    _first_name = value;
  }

  String?_phone;
  String?_address;
  String?_password;
  String?_user_id;
  String?_user_type;

  String? get lastname => _last_name;

  setlastname(String value) {
    _last_name = value;
  }

  String? get Uid => _uid;

  setuid(String value) {
    _uid = value;
  }

  String? get Email => _email;

  setemail(String value) {
    _email = value;
  }

  String? get Phone => _phone;

  setphone(String value) {
    _phone = value;
  }

  String? get Address => _address;

  setaddress(String value) {
    _address = value;
  }

  String? get Password => _password;

  setpassword(String value) {
    _password = value;
  }

  String? get userid => _user_id;

  setuser_id(String value) {
    _user_id = value;
  }

  String? get usertype => _user_type;

  setuser_type(String value) {
    _user_type = value;
  }
}