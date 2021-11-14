import 'package:http/http.dart' as http;

class TemsilciVizeApi {
  static Future getvize(int temsilciid) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/tr_vize_bilgileri?temsilci_id=" +
            temsilciid.toString()));
  }
}
