import 'package:http/http.dart' as http;

class TemsilciIsDeneyimApi {
  static Future getisdeneyim(int temsilciid) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/tr_is_deneyimleri?temsilci_id=" +
            temsilciid.toString()));
  }
}
