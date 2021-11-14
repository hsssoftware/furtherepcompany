import 'package:http/http.dart' as http;

class GrupDetayApi {
  static Future getgrupdetay(
    int grupid,
  ) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/grup_detay?grup_id=" +
            grupid.toString()));
  }
}
