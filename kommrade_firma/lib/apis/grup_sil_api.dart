import 'package:http/http.dart' as http;

class GrupSilApi {
  static Future deletegrup(
    int grupid,
  ) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/grup_sil?grup_id=" +
            grupid.toString()));
  }
}
