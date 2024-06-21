

class Users {
  int? id;
  String? appartName;
  String? userName;
  String? flatNo;
  String? mobileNum;
  String? emailId;
  String? password;
  String? userType;
  String? permenantAddress;
  String? apartId;
  String? adminId;
  String? approval;
  bool?ispressed;
  String?remarks;
  Users(
      {this.id,
        this.appartName,
        this.userName,
        this.flatNo,
        this.mobileNum,
        this.emailId,
        this.password,
        this.userType,
        this.permenantAddress,
        this.apartId,
        this.adminId,
        this.approval,
        this.ispressed,
        this.remarks
      });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appartName = json['appart_name'];
    userName = json['user_name'];
    flatNo = json['flat_no'];
    mobileNum = json['mobile_num'];
    emailId = json['email_id'];
    password = json['password'];
    userType = json['user_type'];
    permenantAddress = json['permenant_address'];
    apartId = json['apartId'];
    adminId = json['adminId'];
    approval = json['approval'];
    ispressed = false;
    remarks = json['remarks'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['appart_name'] = appartName;
    data['user_name'] = userName;
    data['flat_no'] = flatNo;
    data['mobile_num'] = mobileNum;
    data['email_id'] = emailId;
    data['password'] = password;
    data['user_type'] = userType;
    data['permenant_address'] = permenantAddress;
    data['apartId'] = apartId;
    data['adminId'] = adminId;
    data['approval'] = approval;
    data['ispressed'] = ispressed;
    data['remarks'] = remarks;
    return data;
  }
}
