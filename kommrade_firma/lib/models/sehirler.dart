class Sehirlermodel {
  String id;
  String ad;


 

  Sehirlermodel(String id, String ad) {
    this.id = id;
    this.ad = ad;
  
  }

 Sehirlermodel.fromJson(Map json) {
    id = json["SEHIR_ID"].toString();
    ad = json["SEHIR_ADI"].toString();

  }

  Map toJson() {
    return {
      "id": id,
      "ad": ad
    };
  }
}
