import 'package:http/http.dart' as http;

class Sehirapi {
  static Future getsehirler(int ulkeid) {
    return http.get(Uri.parse("http://52.19.0.183:9000/api/v1/values/sehir?ulke_id=" +
        ulkeid.toString()));
  }
}
