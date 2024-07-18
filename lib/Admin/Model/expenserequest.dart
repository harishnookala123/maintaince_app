class ExpenseRequest {
  int?id;
  String? expenseDate;
  int? amount;
  String? expenseType;
  String? description;
  String? apartmentCode;
  String? user_id;
  String? status;
  bool?ispressed;
  ExpenseRequest(
      {
        this.id,
        this.expenseDate,
        this.amount,
        this.expenseType,
        this.description,
        this.apartmentCode,
        this.user_id,
        this.status,
        this.ispressed,
      });

  ExpenseRequest.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    expenseDate = json['expense_date'];
    amount = json['amount'];
    expenseType = json['expense_type'];
    description = json['description'];
    apartmentCode = json['apartment_code'];
    user_id = json['user_id'];
    status = json['status'];
    ispressed = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data['expense_date'] = expenseDate;
    data['amount'] = amount;
    data['expense_type'] = expenseType;
    data['description'] = description;
    data['apartment_code'] = apartmentCode;
    data['user_id'] = user_id;
    data['status'] = status;
    return data;
  }
}
