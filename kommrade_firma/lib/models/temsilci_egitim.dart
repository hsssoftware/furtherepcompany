class TemsilciEgitimModel {
  String id;
  String okulid;
  String tar;
  String puan;
  String seviye;
  String okulad;

  TemsilciEgitimModel(String id, String okulid, String tar, String puan,
      String seviye, String okulad) {
    this.id = id.toString();
    this.okulid = okulid.toString();
    this.tar = tar.toString();
    this.puan = puan.toString();
    this.seviye = seviye.toString();
    this.okulad = okulad.toString();
  }

  TemsilciEgitimModel.fromJson(Map json) {
    id = json["ID"].toString();
    okulid = json["OKUL_ID"].toString();
    tar = json["MEZUNIYET_TARIHI"].toString();
    puan = json["OKUL_PUANI"].toString();
    seviye = json["OKUL_SEVIYE"].toString();
    okulad = json["OKUL_ADI"].toString();
  }

  Map toJson() {
    return {
      "id": id,
      "okulid": okulid,
      "tar": tar,
      "puan": puan,
      "seviye": seviye,
      "okulad": okulad
    };
  }
}
