class TalepBasvuranlarModel {
  String ad;
  String ulke;
  String pozisyon;
  double temsilciid;
  String resimurl;
  int satir;

  TalepBasvuranlarModel(String ad, String ulke, String pozisyon, double temsilciid,
      String resimurl, int satir) {
    this.ad = ad;
    this.ulke = ulke;
    this.pozisyon = pozisyon;
    this.temsilciid = temsilciid;
    this.resimurl = resimurl;
    this.satir = satir;
  }

  TalepBasvuranlarModel.fromJson(Map json) {
    ad = json["AD"].toString();
    ulke = json["ULKE"].toString();
    pozisyon = json["POZISYON"].toString();
    temsilciid = json["TEMSILCI_ID"];
    resimurl = json["RESIM_URL"].toString();
    satir = json["SATIR"];
  }

  Map toJson() {
    return {
      "ad": ad, 
      "ulke": ulke,
      "pozisyon": pozisyon,
      "temsilciid": temsilciid,
      "resimurl": resimurl,
      "satir": satir
    };
  }
}
