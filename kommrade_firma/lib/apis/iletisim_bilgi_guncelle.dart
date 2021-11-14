import 'package:http/http.dart' as http;

class IletisimBilgiGuncelleApi {
  static Future updateiletisimbilgi(int firmaid, int ulkeid, int sehirid,
      String tel, String gsm, String adres, String web, String fax) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/iletisimbilgiguncelle?firma_id=" +
            firmaid.toString() +
            "&ulke_id=" +
            ulkeid.toString() +
            "&sehir_id=" +
            sehirid.toString() +
            "&tel=" +
            tel.toString() +
            "&gsm=" +
            gsm.toString() +
            "&adres=" +
            adres.toString() +
            "&web=" +
            web.toString() +
            "&fax=" +
            fax.toString()));
  }
}
