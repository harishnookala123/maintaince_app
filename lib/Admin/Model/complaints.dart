class Complaints{
  String? user_id;
  String? description;
  String? apartment_code;

  Complaints({this.user_id,
    this.description,
    this.apartment_code});

  factory Complaints.fromJson(Map<String, dynamic> json) {
      return Complaints(
         user_id: json['user_id'],
        description: json['description'],
        apartment_code: json['apartment_code'],
     );
  }
}

