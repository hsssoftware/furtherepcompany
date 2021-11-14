class FirmaBilgilerModel {
  String firmaadi;
  String adres;
  String postakodu;
  String vergino;
  String vergidairesi;
  int calisansayisi;
  String email;
  String web;
  String tel;
  String ceptel;
  String faks;
  String kullaniciadi;
  String resimurl;
  int maildurum;
  int dil;
  String urunaciklama;
  String nacekodu;
  int sirkettipi;
  int ticaretturu;
  int kurulusyil;
  String yetkiliadi;
  String yetkilisoyadi;
  String yetkiliceptel;
  String yetkilimail;
  String ulkeadi;
  String sektoradi;
  String iladi;

  FirmaBilgilerModel(
      String firmaadi,
      String adres,
      String postakodu,
      String vergino,
      String vergidairesi,
      int calisansayisi,
      String email,
      String web,
      String tel,
      String ceptel,
      String faks,
      String kullaniciadi,
      String resimurl,
      int maildurum,
      int dil,
      String urunaciklama,
      String nacekodu,
      int sirkettipi,
      int ticaretturu,
      int kurulusyil,
      String yetkiliadi,
      String yetkilisoyadi,
      String yetkiliceptel,
      String yetkilimail,
      String ulkeadi,
      String sektoradi,
      String iladi) {
    this.firmaadi = firmaadi;
    this.adres = adres;
    this.postakodu = postakodu;
    this.vergino = vergino;
    this.vergidairesi = vergidairesi;
    this.calisansayisi = calisansayisi;
    this.email = email;
    this.web = web;
    this.tel = tel;
    this.ceptel = ceptel;
    this.faks = faks;
    this.kullaniciadi = kullaniciadi;
    this.resimurl = resimurl;
    this.maildurum = maildurum;
    this.dil = dil;
    this.urunaciklama = urunaciklama;
    this.nacekodu = nacekodu;
    this.sirkettipi = sirkettipi;
    this.ticaretturu = ticaretturu;
    this.kurulusyil = kurulusyil;
    this.yetkiliadi = yetkiliadi;
    this.yetkilisoyadi = yetkilisoyadi;
    this.yetkiliceptel = yetkiliceptel;
    this.yetkilimail = yetkilimail;
    this.ulkeadi = ulkeadi;
    this.sektoradi = sektoradi;
    this.iladi = iladi;
  }

  FirmaBilgilerModel.fromJson(Map json) {
    firmaadi = json["FIRMA_ADI"].toString();
    adres = json["ADRES"].toString();
    postakodu = json["POSTA_KODU"].toString();
    vergino = json["VERGI_NO"].toString();
    vergidairesi = json["VERGI_DAIRESI"].toString();
    calisansayisi = json["CALISAN_SAYISI"];
    email = json["E_MAIL"].toString();
    web = json["WEB_SITESI"].toString();
    tel = json["TEL"].toString();
    ceptel = json["CEP_TEL"].toString();
    faks = json["FAKS"].toString();
    kullaniciadi = json["KULLANICI_ADI"].toString();
    resimurl = json["RESIM_URL"].toString();
    maildurum = json["MAIL_DURUMU"];
    dil = json["DIL"];
    urunaciklama = json["URUN_ACIKLAMA"].toString();
    nacekodu = json["NACE_KODU"].toString();
    sirkettipi = json["SIRKET_TIPI"];
    ticaretturu = json["DIS_TICARET_TURU"];
    kurulusyil = json["KURULUS_YILI"];
    yetkiliadi = json["YETKILI_ADI"].toString();
    yetkilisoyadi = json["YETKILI_SOYADI"].toString();
    yetkiliceptel = json["YETKILI_CEP_TEL"].toString();
    yetkilimail = json["YETKILI_EMAIL"].toString();
    ulkeadi = json["ULKE_ADI"].toString();
    sektoradi = json["SEKTOR_ADI"].toString();
    iladi = json["IL_ADI"].toString();
  }

  Map toJson() {
    return {
      "firmaadi": firmaadi,
      "adres": adres,
      "postakodu": postakodu,
      "vergino": vergino,
      "vergidairesi": vergidairesi,
      "calisansayisi": calisansayisi,
      "email": email,
      "web": web,
      "tel": tel,
      "ceptel": ceptel,
      "faks": faks,
      "kullaniciadi": kullaniciadi,
      "resimurl": resimurl,
      "maildurum": maildurum,
      "dil": dil,
      "urunaciklama": urunaciklama,
      "nacekodu": nacekodu,
      "sirkettipi": sirkettipi,
      "ticaretturu": ticaretturu,
      "kurulusyil": kurulusyil,
      "yetkiliadi": yetkiliadi,
      "yetkilisoyadi": yetkilisoyadi,
      "yetkiliceptel": yetkiliceptel,
      "yetkilimail": yetkilimail,
      "ulkeadi": ulkeadi,
      "sektoradi": sektoradi,
      "iladi": iladi
    };
  }
}
