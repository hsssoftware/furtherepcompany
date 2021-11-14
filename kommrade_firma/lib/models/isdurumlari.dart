class IsDurumlariModel {
  String id;
  String ad;
  

 

  IsDurumlariModel(String id, String ad) {
    this.id = id;
    this.ad = ad;
 

  }

 IsDurumlariModel.fromJson(Map json) {
    id = json["ID"].toString();
    ad = json["IS_DURUMU"].toString();

  }

  Map toJson() {
    return {
      "id": id,
      "ad": ad
    };
  }
}
