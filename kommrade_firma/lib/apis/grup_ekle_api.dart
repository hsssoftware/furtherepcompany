import 'package:http/http.dart' as http;

class GrupEkleApi {
  static Future postgrup(
    int firmaid,
    String grupadi,
  ) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/grup_ekle?firma_id=" +
            firmaid.toString() +
            "&grup_adi=" +
            grupadi.toString()));
  }
}
