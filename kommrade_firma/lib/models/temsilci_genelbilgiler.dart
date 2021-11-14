class TemsilciGenelBilgilerModel {
  String ad;
  String soyad;
  String ulke;
  String sehir;
  String pozisyon;
  String email;
  String kuladi;
  String dogumtar;
  String resimurl;
  String medenidurum;
  String cinsiyet;
  String isdurum;
  String ceptel;
  String evtel;
  String adres;
  String facebook;
  String linkedin;
  String skype;
  String qq;
  String wechat;
  String hakkinda;

  TemsilciGenelBilgilerModel(
      String ad,
      String soyad,
      String ulke,
      String sehir,
      String pozisyon,
      String email,
      String kuladi,
      String dogumtar,
      String resimurl,
      String medenidurum,
      String cinsiyet,
      String isdurum,
      String ceptel,
      String evtel,
      String adres,
      String facebook,
      String linkedin,
      String skype,
      String qq,
      String wechat,
      String hakkinda) {
    this.ad = ad.toString();
    this.soyad = soyad.toString();
    this.ulke = ulke.toString();
    this.sehir = sehir.toString();
    this.pozisyon = pozisyon.toString();
    this.email = email.toString();
    this.kuladi = kuladi.toString();
    this.dogumtar = dogumtar.toString();
    this.resimurl = resimurl.toString();
    this.medenidurum = medenidurum.toString();
    this.cinsiyet = cinsiyet.toString();
    this.isdurum = isdurum.toString();
    this.ceptel = ceptel.toString();
    this.evtel = evtel.toString();
    this.adres = adres.toString();
    this.facebook = facebook.toString();
    this.linkedin = linkedin.toString();
    this.skype = skype.toString();
    this.qq = qq.toString();
    this.wechat = wechat.toString();
    this.hakkinda = hakkinda.toString();
  }

  TemsilciGenelBilgilerModel.fromJson(Map json) {
    ad = json["AD"].toString();
    soyad = json["SOYAD"].toString();
    ulke = json["ULKE_ADI"].toString();
    sehir = json["SEHIR_ADI"].toString();
    pozisyon = json["POZISYON"].toString();
    email = json["E_MAIL"].toString();
    kuladi = json["KULLANICI_ADI"].toString();
    dogumtar = json["DOGUM_TARIHI"].toString();
    resimurl = json["RESIM_URL"].toString();
    medenidurum = json["MEDENI_DURUMU"].toString();
    cinsiyet = json["CINSIYET"].toString();
    isdurum = json["IS_DURUMU"].toString();
    ceptel = json["CEP_TEL"].toString();
    evtel = json["EV_TEL"].toString();
    adres = json["ADRES"].toString();
    facebook = json["FACEBOOK"].toString();
    linkedin = json["LINKEDIN"].toString();
    skype = json["SKYPE"].toString();
    qq = json["QQ"].toString();
    wechat = json["WE_CHAT"].toString();
    hakkinda = json["HAKKINDA"].toString();
  }

  Map toJson() {
    return {
      "ad": ad,
      "soyad": soyad,
      "ulke": ulke,
      "sehir": sehir,
      "pozisyon": pozisyon,
      "email": email,
      "kuladi": kuladi,
      "dogumtar": dogumtar,
      "resimurl": resimurl,
      "medenidurum": medenidurum,
      "cinsiyet": cinsiyet,
      "isdurum": isdurum,
      "ceptel": ceptel,
      "evtel": evtel,
      "adres": adres,
      "facebook": facebook,
      "linkedin": linkedin,
      "skype": skype,
      "qq": qq,
      "wechat": wechat,
      "hakkinda": hakkinda
    };
  }
}
