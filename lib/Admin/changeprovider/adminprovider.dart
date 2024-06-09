import 'package:flutter/foundation.dart';

class AdminRegistrationModel with ChangeNotifier {
  String _apartName = '';
  String _apartAddress = '';
  String _noOfFlats = '';
  String _images = '';
  String _name = "";
  String _email = "";
  String _phone = "";
  String _password = "";
  String get apartName => _apartName;
  String get apartAddress => _apartAddress;
  String get noOfFlats => _noOfFlats;
  String get images => _images;

  void setApartName(String apartName) {
    _apartName = apartName;
    notifyListeners();
  }

  void setApartAddress(String apartAddress) {
    _apartAddress = apartAddress;
    notifyListeners();
  }

  void setNoOfFlats(String noOfFlats) {
    _noOfFlats = noOfFlats;
    notifyListeners();
  }

  void setImages(String images) {
    _images = images;
    notifyListeners();
  }

  String get email => _email;

  void setEmail(String value) {
    _email = value;
  }

  String get phone => _phone;

  void setPhone(String value) {
    _phone = value;
  }

  String get password => _password;

  void setPassword(String value) {
    _password = value;
  }
  String get name => _name;

  void setName(String value) {
    _name = value;
  }

}
