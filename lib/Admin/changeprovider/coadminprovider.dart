import 'package:flutter/cupertino.dart';

class CoAdmin with ChangeNotifier {
String _name ="";

String get name => _name;

  setname(String value) {
    _name = value;
    notifyListeners();
  }

  int  _id = 0;

int get id => _id;

  setid(int value) {
    _id = value;
    notifyListeners();
  }

}