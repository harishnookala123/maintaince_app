class ExpenseRequest {
  String? expenseDate;
  int? amount;
  String? expenseType;
  String? description;
  String? apartmentCode;
  String? userId;
  String? status;

  ExpenseRequest(
      {this.expenseDate,
        this.amount,
        this.expenseType,
        this.description,
        this.apartmentCode,
        this.userId,
        this.status});

  ExpenseRequest.fromJson(Map<String, dynamic> json) {
    expenseDate = json['expense_date'];
    amount = json['amount'];
    expenseType = json['expense_type'];
    description = json['description'];
    apartmentCode = json['apartment_code'];
    userId = json['user_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expense_date'] = expenseDate;
    data['amount'] = amount;
    data['expense_type'] = expenseType;
    data['description'] = description;
    data['apartment_code'] = apartmentCode;
    data['user_id'] = userId;
    data['status'] = status;
    return data;
  }
}
