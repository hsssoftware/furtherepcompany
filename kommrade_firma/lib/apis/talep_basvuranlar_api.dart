import 'package:http/http.dart' as http;

class TalepBasvuruApi {
  static Future gettalep(int talepid) {
    return http.post(Uri.parse("http://52.19.0.183:9000/api/v1/values/tr_ilan_basvuranlar?talep_id="+talepid.toString()));
  }
}
