class Admin {
  int? id;
  String? apartname;
  String? adminname;
  int? noOfFlats;
  String? mobilenumber;
  String? address;
  String? adminId;
  String? apartId;
  bool?pressed;
  Admin(
      {this.id,
        this.apartname,
        this.adminname,
        this.noOfFlats,
        this.mobilenumber,
        this.address,
        this.adminId,
        this.apartId,
        this.pressed,
      });

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apartname = json['apartname'];
    adminname = json['adminname'];
    noOfFlats = json['noOfFlats'];
    mobilenumber = json['mobilenumber'];
    address = json['address'];
    adminId = json['userid'];
    apartId = json["apartId"];
    pressed = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['apartname'] = apartname;
    data['adminname'] = adminname;
    data['noOfFlats'] = noOfFlats;
    data['mobilenumber'] = mobilenumber;
    data['address'] = address;
    data['adminId'] = adminId;
    data["apartId"] = apartId;
    data["pressed"] = pressed;
    return data;
  }
}
