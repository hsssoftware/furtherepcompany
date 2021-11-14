class TemsilciIsDeneyimModel {
  String id;
  String firmadi;
  String gorev;
  String girtar;
  String ciktar;
  String sebep;
  String ulke;
  String sehir;

  TemsilciIsDeneyimModel(String id, String firmadi, String gorev, String girtar,
      String ciktar, String sebep, String ulke, String sehir) {
    this.id = id.toString();
    this.firmadi = firmadi.toString();
    this.gorev = gorev.toString();
    this.girtar = girtar.toString();
    this.ciktar = ciktar.toString();
    this.sebep = sebep.toString();
    this.ulke = ulke.toString();
    this.sehir = sehir.toString();
  }

  TemsilciIsDeneyimModel.fromJson(Map json) {
    id = json["ID"].toString();
    firmadi = json["FIRMA_ADI"].toString();
    gorev = json["GOREV"].toString();
    girtar = json["GIRIS_TARIHI"].toString();
    ciktar = json["CIKIS_TARIHI"].toString();
    sebep = json["AYRILIS_SEBEBI"].toString();
    ulke = json["ULKE_ADI"].toString();
    sehir = json["SEHIR_ADI"].toString();
  }

  Map toJson() {
    return {
      "id": id,
      "firmadi": firmadi,
      "gorev": gorev,
      "girtar": girtar,
      "ciktar": ciktar,
      "sebep": sebep,
      "ulke": ulke,
      "sehir": sehir
    };
  }
}
