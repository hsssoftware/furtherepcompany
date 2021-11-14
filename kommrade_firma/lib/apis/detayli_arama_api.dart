import 'package:http/http.dart' as http;

class DetayliAramaApi {
  static Future getarama(
      int pozisyonid,
      int ulkeid,
      int durumid,
      int yas1,
      int yas2,
      int sehirid,
      int ticaretturu,
      String pozisyonlar,
      String ulkeler,
      String sehirler,
      String durumlar,
      String aramadeger) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/tr_detayli_arama?" +
            "pozisyon_id=" +
            pozisyonid.toString() +
            "&ulke_id=" +
            ulkeid.toString() +
            "&durumu=" +
            durumid.toString() +
            "&yas1=" +
            yas1.toString() +
            "&yas2=" +
            yas2.toString() +
            "&sehir=" +
            sehirid.toString() +
            "&ticaretturu=" +
            ticaretturu.toString() +
            "&pozisyonlar=" +
            pozisyonlar.toString() +
            "&ulkeler=" +
            ulkeler.toString() +
            "&sehirler=" +
            sehirler.toString() +
            "&durumlar=" +
            durumlar.toString() +
            "&arama_degeri=" +
            aramadeger.toString()));
  }
}
