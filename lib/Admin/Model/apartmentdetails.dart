class ApartmentDetails {
  String? apartmentCode;
  String? apartmentName;
  String? blockName;
  String? flatNo;

  ApartmentDetails(
      {this.apartmentCode, this.apartmentName, this.blockName, this.flatNo});

  ApartmentDetails.fromJson(Map<String, dynamic> json) {
    apartmentCode = json['apartment_code'];
    apartmentName = json['apartment_name'];
    blockName = json['block_name'];
    flatNo = json['flat_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apartment_code'] = apartmentCode;
    data['apartment_name'] = apartmentName;
    data['block_name'] = blockName;
    data['flat_no'] = flatNo;
    return data;
  }
}
