import 'package:http/http.dart' as http;

class TemsilciGenelApi {
  static Future getgenel(int temsilciid) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/tr_genel_bilgiler?temsilci_id=" +
            temsilciid.toString()));
  }
}
