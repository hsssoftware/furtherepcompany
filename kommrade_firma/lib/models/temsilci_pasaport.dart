class TemsilciPasaportModel {
  String id;
  String no;
  String bastar;
  String bittar;
  String ulke;
  String tip;

  TemsilciPasaportModel(String id, String no, String bastar, String bittar,
      String ulke, String tip) {
    this.id = id.toString();
    this.no = no.toString();
    this.bastar = bastar.toString();
    this.bittar = bittar.toString();
    this.ulke = ulke.toString();
    this.tip = tip.toString();
  }

  TemsilciPasaportModel.fromJson(Map json) {
    id = json["ID"].toString();
    no = json["PASAPORT_NO"].toString();
    bastar = json["BAS_TAR"].toString();
    bittar = json["BIT_TAR"].toString();
    ulke = json["ULKE_ADI"].toString();
    tip = json["PASAPORT_TIPI"].toString();
  }

  Map toJson() {
    return {
      "id": id,
      "no": no,
      "bastar": bastar,
      "bittar": bittar,
      "ulke": ulke,
      "tip": tip
    };
  }
}
