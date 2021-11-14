class GrupDetayModel {
  String ad;
  String ulke;
  String pozisyon;
  int temsilciid;
  String resimurl;
  double grupid;
  String grupadi;

  GrupDetayModel(String ad, String ulke, String pozisyon, int temsilciid,
      String resimurl, double grupid,String grupadi) {
    this.ad = ad;
    this.ulke = ulke;
    this.pozisyon = pozisyon;
    this.temsilciid = temsilciid;
    this.resimurl = resimurl;
    this.grupid = grupid;
    this.grupadi = grupadi;
  }

  GrupDetayModel.fromJson(Map json) {
    ad = json["AD"].toString();
    ulke = json["ULKE_ADI"].toString();
    pozisyon = json["POZISYON"].toString();
    temsilciid = json["TEMSILCI_ID"];
    resimurl = json["RESIM_URL"].toString();
    grupid = json["GRUP_ID"];
    grupadi = json["GRUP_ADI"];
  }

  Map toJson() {
    return {
      "ad": ad,
      "ulke": ulke,
      "pozisyon": pozisyon,
      "temsilciid": temsilciid,
      "resimurl": resimurl,
      "grupid": grupid,
      "grupadi": grupadi
    };
  }
}
