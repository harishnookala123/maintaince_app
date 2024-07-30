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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["apartment_code"] = apartment_code;
    data["maintenance_amount"] = maintenance_amount;
    data["generate_date"] = generate_date;
    return data;
  }
}