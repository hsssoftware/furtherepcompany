import 'package:http/http.dart' as http;

class YetkiliBilgiGuncelleApi {
  static Future updateyetkilibilgi(
      int firmaid, String ad, String soyad, String tel, String email) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/yetkilibilgiguncelle?firma_id=" +
            firmaid.toString() +
            "&ad=" +
            ad.toString() +
            "&soyad=" +
            soyad.toString() +
            "&tel=" +
            tel.toString() +
            "&e_mail=" +
            email.toString()));
  }
}
