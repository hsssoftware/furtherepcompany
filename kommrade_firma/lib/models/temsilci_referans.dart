class TemsilciReferansModel {
  String id;
  String adsoyad;
  String firmadi;
  String tel;
  String email;
  String unvan;

  TemsilciReferansModel(String id, String firmadi, String adsoyad, String tel,
      String email, String unvan) {
    this.id = id.toString();
    this.adsoyad = adsoyad.toString();
    this.firmadi = firmadi.toString();
    this.tel = tel.toString();
    this.email = email.toString();
    this.unvan = unvan.toString();
  }

  TemsilciReferansModel.fromJson(Map json) {
    id = json["ID"].toString();
    adsoyad = json["ADI_SOYADI"].toString();
    firmadi = json["FIRMA_ADI"].toString();
    tel = json["TEL"].toString();
    email = json["E_MAIL"].toString();
    unvan = json["UNVAN"].toString();
  }

  Map toJson() {
    return {
      "id": id,
      "adsoyad": adsoyad,
      "firmadi": firmadi,
      "tel": tel,
      "email": email,
      "unvan": unvan
    };
  }
}
