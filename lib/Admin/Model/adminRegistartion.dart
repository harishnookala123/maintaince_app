class AdminRegistration {
  String? apartmentName;
  String? apartAddress;
  String? noOfFlats;
  String? images;
  String? adminName;
  String? email;
  String? phonenumber;
  String? password;

  AdminRegistration(
      {this.apartmentName,
        this.apartAddress,
        this.noOfFlats,
        this.images,
        this.adminName,
        this.email,
        this.phonenumber,
        this.password});

  AdminRegistration.fromJson(Map<String, dynamic> json) {
    apartmentName = json['apartmentName'];
    apartAddress = json['apartAddress'];
    noOfFlats = json['noOfFlats'];
    images = json['Images'];
    adminName = json['adminName:'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apartmentName'] = apartmentName;
    data['apartAddress'] = apartAddress;
    data['noOfFlats'] = noOfFlats;
    data['Images'] = images;
    data['adminName:'] = adminName;
    data['email'] = email;
    data['phonenumber'] = phonenumber;
    data['password'] = password;
    return data;
  }

}
