import 'package:http/http.dart' as http;

class Anasayfaapi {
  static Future getanasayfa(int sayfa) {
    return http.post(Uri.parse("http://52.19.0.183:9000/api/v1/values/tr_anasayfa?sayfa="+sayfa.toString()));
  }
}
