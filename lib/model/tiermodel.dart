class TierModel{
  dynamic name;


  TierModel({
    this.name,
  });

  factory TierModel.fromJson(Map<dynamic, dynamic>json){

    return TierModel(
      name: json["name"],
    );
  }


}
