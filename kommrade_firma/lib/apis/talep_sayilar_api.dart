import 'package:http/http.dart' as http;
import 'package:kommrade_firma/models/degiskenler.dart';

class TalepSayilarApi {
  static Future gettalepsayi() {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/talep_sayilar?firma_id=" +
            Degiskenler.firmaid.toString()));
  }
}
