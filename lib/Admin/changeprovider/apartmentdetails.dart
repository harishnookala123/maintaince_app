import 'package:flutter/cupertino.dart';

class ApartDetails with ChangeNotifier {
  String? _apartname;

  String? get apartName => _apartname;

  setApartname(String value) {
    _apartname = value;
  }

  int? _blocks;
  String? _apartmentCode;

  int? get block => _blocks;

  setBlocks(int value) {
    _blocks = value;
  }

  String? get apartCode => _apartmentCode;

  setApartmentCode(String value) {
    _apartmentCode = value;
  }
}
