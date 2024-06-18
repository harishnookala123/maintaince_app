class Admin {
  int? id;
  String? apartname;
  String? adminname;
  int? noOfFlats;
  String? mobilenumber;
  String? address;
  String? userid;

  Admin(
      {this.id,
        this.apartname,
        this.adminname,
        this.noOfFlats,
        this.mobilenumber,
        this.address,
        this.userid});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apartname = json['apartname'];
    adminname = json['adminname'];
    noOfFlats = json['noOfFlats'];
    mobilenumber = json['mobilenumber'];
    address = json['address'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['apartname'] = this.apartname;
    data['adminname'] = this.adminname;
    data['noOfFlats'] = this.noOfFlats;
    data['mobilenumber'] = this.mobilenumber;
    data['address'] = this.address;
    data['userid'] = this.userid;
    return data;
  }
}
