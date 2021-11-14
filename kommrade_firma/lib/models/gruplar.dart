class GruplarModel {
  double id;
  String grupadi;

  GruplarModel(double id, String grupadi) {
    this.id = id;
    this.grupadi = grupadi;
  }

  GruplarModel.fromJson(Map json) {
    id = json["GRUP_ID"];
    grupadi = json["GRUP_ADI"];
  }

  Map toJson() {
    return {"id": id, "grupadi": grupadi};
  }
}
