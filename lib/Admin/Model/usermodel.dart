

class Users {
  String? uid;
  String? apartment_name;
  String? block_name;
  String? first_name;
  String? last_name;
  String? flat_no;
  String? phone;
  String? email;
  String? password;
  String? user_type;
  String? address;
  String? apartment_code;
  String? admin_id;
  bool? ispressed;
  String?status;
  String?remarks;
  Users(
      {this.uid,
        this.apartment_name,
        this.first_name,
        this.last_name,
        this.flat_no,
        this.phone,
        this.email,
        this.password,
        this.user_type,
        this.address,
        this.apartment_code,
        this.admin_id,
        this.block_name,
        this.status,
        this.ispressed,
        this.remarks
      });

  Users.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    apartment_name = json['apartment_name'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    flat_no = json['flat_no'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    user_type = json['user_type'];
    address = json['address'];
    apartment_code = json['apartment_code'];
    admin_id = json['admin_id'];
    status = json['status'];
    ispressed = false;
    block_name = json["block_name"];
    remarks = json['remarks'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['apartment_name'] = apartment_name;
    data['firstname'] = first_name;
    data['last_name'] = last_name;
    data['flat_no'] = flat_no;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['user_type'] = user_type;
    data['address'] = address;
    data['apartment_code'] = apartment_code;
    data['admin_id'] = admin_id;
    data['status'] = status;
    data['block_name'] = block_name;
    data['ispressed'] = ispressed;
    data['remarks'] = remarks;
    return data;
  }
}
