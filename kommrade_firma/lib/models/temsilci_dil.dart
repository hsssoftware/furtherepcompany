class TemsilciDilModel {
  String id;
  String seviye;
  String dil;

  TemsilciDilModel(String id, String seviye, String dil) {
    this.id = id.toString();
    this.seviye = seviye.toString();
    this.dil = dil.toString();
  }

  TemsilciDilModel.fromJson(Map json) {
    id = json["ID"].toString();
    seviye = json["SEVIYE_ADI"].toString();
    dil = json["DIL"].toString();
  }

  Map toJson() {
    return {"id": id, "seviye": seviye, "dil": dil};
  }
}
