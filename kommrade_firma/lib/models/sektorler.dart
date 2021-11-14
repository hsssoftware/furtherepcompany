class Sektormodel {
  String id;
  String sektor;

 

  Sektormodel(String id, String sektor) {
    this.id = id;
    this.sektor = sektor;

  }

 Sektormodel.fromJson(Map json) {
    id = json["ID"].toString();
    sektor = json["SEKTOR"].toString();
  }

  Map toJson() {
    return {
      "id": id,
      "sektor": sektor
    };
  }
}
