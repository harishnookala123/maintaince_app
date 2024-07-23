class MaintainceBill {
  String? message;
  List<Result>? result;

  MaintainceBill({this.message, this.result});

  MaintainceBill.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? userId;
  String? apartmentName;
  String? apartmentCode;
  String? blockName;
  String? adminId;
  int? amount;
  String? maintenanceDate;

  Result(
      {this.id,
        this.userId,
        this.apartmentName,
        this.apartmentCode,
        this.blockName,
        this.adminId,
        this.amount,
        this.maintenanceDate});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    apartmentName = json['apartment_name'];
    apartmentCode = json['apartment_code'];
    blockName = json['block_name'];
    adminId = json['admin_id'];
    amount = json['amount'];
    maintenanceDate = json['maintenance_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['apartment_name'] = apartmentName;
    data['apartment_code'] = apartmentCode;
    data['block_name'] = blockName;
    data['admin_id'] = adminId;
    data['amount'] = amount;
    data['maintenance_date'] = maintenanceDate;
    return data;
  }
}
