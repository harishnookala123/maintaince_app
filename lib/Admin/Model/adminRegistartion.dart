class Admin {
  String? adminId;
  String? firstName;
  String? lastName;
  String? apartmentName;
  String? apartmentCode;
  String? email;
  String? address;
  String? phone;
  String? adminType;

  Admin(
      {this.adminId,
        this.firstName,
        this.lastName,
        this.apartmentName,
        this.apartmentCode,
        this.email,
        this.address,
        this.phone,
        this.adminType});

  Admin.fromJson(Map<String, dynamic> json) {
    adminId = json['adminId'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    apartmentName = json['apartment_name'];
    apartmentCode = json['apartment_code'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    adminType = json['admin_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adminId'] = adminId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['apartment_name'] = apartmentName;
    data['apartment_code'] = apartmentCode;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['admin_type'] = adminType;
    return data;
  }
}
