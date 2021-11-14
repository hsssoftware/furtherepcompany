import 'package:http/http.dart' as http;

class GrupTemsilciSilApi {
  static Future deletetemsilcigrup(int grupid, int temsilciid) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/grup_temsilci_sil?grup_id=" +
            grupid.toString() +
            "&temsilci_id=" +
            temsilciid.toString()));
  }
}
