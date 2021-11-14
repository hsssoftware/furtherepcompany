import 'package:http/http.dart' as http;

class TalepSilApi {
  static Future deletetalep(int talepid) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/talep_sil?talep_id=" +
            talepid.toString()));
  }
}
