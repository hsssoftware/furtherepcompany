class TaleplerModel {
  double id;
  String pozisyon;
  String firmadi;
  String aciklama;
  int ilantipi;
  int basvurusayi;
  int goruntulemesayi;
  String ulke;
  String il;
  int tecrube;
  String bastar;
  String bittar;
  String ticaretturu;

  TaleplerModel(
      double id,
      String pozisyon,
      String firmadi,
      String aciklama,
      int ilantipi,
      int basvurusayi,
      int goruntulemesayi,
      String ulke,
      String il,
      int tecrube,
      String bastar,
      String bittar,
      String ticaretturu) {
    this.id = id;
    this.pozisyon = pozisyon;
    this.firmadi = firmadi;
    this.aciklama = aciklama;
    this.ilantipi = ilantipi;
    this.basvurusayi = basvurusayi;
    this.goruntulemesayi = goruntulemesayi;
    this.ulke = ulke;
    this.tecrube = tecrube;
    this.il = il;
    this.bastar = bastar;
    this.bittar = bittar;
    this.ticaretturu = ticaretturu;
  }

  TaleplerModel.fromJson(Map json) {
    id = json["ID"];
    pozisyon = json["POZISYON"];
    firmadi = json["FIRMA_ADI"];
    aciklama = json["ACIKLAMA"];
    ilantipi = json["ILAN_TIPI"];
    basvurusayi = json["BASVURU_SAYISI"];
    goruntulemesayi = json["GORUNTULEME_SAYISI"];
    ulke = json["ULKE_ADI"];
    il = json["IL_ADI"];
    tecrube = json["TECRUBE"];
    bastar = json["BASLANGIC_TARIHI"].toString();
    bittar = json["BITIS_TARIHI"].toString();
    ticaretturu = json["TICARET_TURU"];
  }

  Map toJson() {
    return {
      "id": id,
      "pozisyon": pozisyon,
      "firmadi": firmadi,
      "aciklama": aciklama,
      "ilantipi": ilantipi,
      "basvurusayi": basvurusayi,
      "goruntulemesayi": goruntulemesayi,
      "ulke": ulke,
      "il": il,
      "tecrube": tecrube,
      "bastar": bastar,
      "bittar": bittar,
      "ticaretturu": ticaretturu
    };
  }
}
