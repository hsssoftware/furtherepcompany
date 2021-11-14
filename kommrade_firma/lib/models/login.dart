class Login {
  String firmaid;
  String email;
  String kullaniciadi;
  String sifre;
  String resimurl;

  Login(String firmaid, String email, String kullaniciadi,
      String sifre, String resimurl) {
    this.firmaid = firmaid;
    this.email = email;
    this.kullaniciadi = kullaniciadi;
    this.sifre = sifre;
    this.resimurl = resimurl;
  }

  Login.fromJson(Map json) {
    firmaid = json["FIRMA_ID"].toString();
    email = json["E_MAIL"].toString();
    kullaniciadi = json["KULLANICI_ADI"].toString();
    sifre = json["SIFRE"].toString();
    resimurl = json["RESIM_URL"].toString();
  }

  Map toJson() {
    return {
      "firma_id": firmaid,
      "e_mail": email,
      "kullanici_adi": kullaniciadi,
      "sifre": sifre,
      "resimurl": resimurl
    };
  }
}
