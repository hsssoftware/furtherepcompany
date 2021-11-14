import 'package:http/http.dart' as http;
import 'package:kommrade_firma/models/degiskenler.dart';

class FirmaBilgilerapi {
  static Future getfirma() {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/tr_firma_genel_bilgiler?firma_id=" +
            Degiskenler.firmaid.toString()));
  }
}
