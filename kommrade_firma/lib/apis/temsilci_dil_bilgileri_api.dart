import 'package:http/http.dart' as http;

class TemsilciDilApi {
  static Future getdil(int temsilciid) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/tr_dil_bilgileri?temsilci_id=" +
            temsilciid.toString()));
  }
}
