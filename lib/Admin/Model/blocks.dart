class BlockNames {
  String? blockName;

  BlockNames({this.blockName});

  BlockNames.fromJson(Map<String, dynamic> json) {
    blockName = json['block_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['block_name'] = blockName;
    return data;
  }
}