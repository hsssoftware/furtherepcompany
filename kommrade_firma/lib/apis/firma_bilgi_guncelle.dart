import 'package:http/http.dart' as http;

class FirmaBilgiGuncelleApi {
  static Future updatefirmabilgi(
      int firmaid,
      String firmadi,
      String vno,
      String vdairesi,
      String nace,
      String adres,
      String postakodu,
      int yil,
      int calisan,
      int sektorid) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/firmabilgiguncelle?firma_id=" +
            firmaid.toString() +
            "&firma_adi=" +
            firmadi.toString() +
            "&vno=" +
            vno.toString() +
            "&vdairesi=" +
            vdairesi.toString() +
            "&nace=" +
            nace.toString() +
            "&adres=" +
            adres.toString() +
            "&posta_kodu=" +
            postakodu.toString() +
            "&kurulusyil=" +
            yil.toString() +
            "&calisan=" +
            calisan.toString() +
            "&sektor_id=" +
            sektorid.toString()));
  }
}
