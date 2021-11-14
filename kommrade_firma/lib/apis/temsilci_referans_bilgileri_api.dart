import 'package:http/http.dart' as http;

class TemsilciReferansApi {
  static Future getreferans(int temsilciid) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/referanslar?temsilci_id=" +
            temsilciid.toString()));
  }
}
