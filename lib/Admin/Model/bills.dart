class Bills{
  String?apartment_code;
  int?maintenance_amount;
  String?generate_date;

  Bills({this.apartment_code, this.maintenance_amount, this.generate_date});
  Bills.fromJson(Map<String, dynamic> json) {
    apartment_code = json["apartment_code"];
    maintenance_amount  = json["maintenance_amount"];
    generate_date = json ["generate_date"];
  }
}