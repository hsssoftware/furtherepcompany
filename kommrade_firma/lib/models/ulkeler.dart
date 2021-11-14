class Ulkelermodel {
  String id;
  String ad;


 

  Ulkelermodel(String id, String ad) {
    this.id = id;
    this.ad = ad;

  }

 Ulkelermodel.fromJson(Map json) {
    id = json["ULKE_ID"].toString();
    ad = json["ULKE_ADI"].toString();
  }

  Map toJson() {
    return {
      "id": id,
      "ad": ad
    };
  }
}
