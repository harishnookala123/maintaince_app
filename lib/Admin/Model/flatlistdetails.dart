class FlatDetails {
  String? apartId;
  String? apartname;
  int? floors;
  String? flat;
  String? blockname;
  String? status;

  FlatDetails(
      {this.apartId,
        this.apartname,
        this.floors,
        this.flat,
        this.blockname,
        this.status});

  FlatDetails.fromJson(Map<String, dynamic> json) {
    apartId = json['apartId'];
    apartname = json['apartname'];
    floors = json['floors'];
    flat = json['flat'];
    blockname = json['blockname'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apartId'] = apartId;
    data['apartname'] = apartname;
    data['floors'] = floors;
    data['flat'] = flat;
    data['blockname'] = blockname;
    data['status'] = status;
    return data;
  }
}
