class Complaints{
  String? user_id;
  int? id;
  String? description;
  String? apartment_code;
  String?complaint_type;
  bool?pressed;
  String?image;
  Complaints({this.user_id,
    this.id,
    this.description,
    this.apartment_code,
    this.complaint_type,
    this.pressed,
    this.image
  });

  factory Complaints.fromJson(Map<String, dynamic> json) {
      return Complaints(
         user_id: json['user_id'],
        id: json['id'],
        description: json['description'],
        apartment_code: json['apartment_code'],
          complaint_type : json["complaint_type"],
           pressed: false,
          image: json["image"],
     );
  }
}

