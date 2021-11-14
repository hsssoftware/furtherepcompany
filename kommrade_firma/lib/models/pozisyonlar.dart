class Pozisyonlarmodel {
  String id;
  String ad;
  String resimurl;

 

  Pozisyonlarmodel(String id, String ad,String resimurl) {
    this.id = id;
    this.ad = ad;
    this.resimurl = resimurl;

  }

 Pozisyonlarmodel.fromJson(Map json) {
    id = json["POZISYON_ID"].toString();
    ad = json["POZISYON_ADI"].toString();
    resimurl = json["RESIM_URL"].toString();
  }

  Map toJson() {
    return {
      "id": id,
      "ad": ad,
      "resimurl": resimurl
    };
  }
}
