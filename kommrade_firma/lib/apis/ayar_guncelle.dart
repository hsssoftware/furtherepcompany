import 'package:http/http.dart' as http;

class AyarGuncelleApi {
  static Future updateayar(int firmaid, String kuladi, String email,
      String pass1, String pass2, int emailayar, int dil, String playerid) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/ayarguncelle?firma_id=" +
            firmaid.toString() +
            "&kullanici_adi=" +
            kuladi.toString() +
            "&e_mail=" +
            email.toString() +
            "&pass1=" +
            pass1.toString() +
            "&pass2=" +
            pass2.toString() +
            "&e_mail_ayar=" +
            emailayar.toString() +
            "&dil=" +
            dil.toString() +
            "&player_id=" +
            playerid.toString()));
  }
}
