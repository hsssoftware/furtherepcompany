import 'package:http/http.dart' as http;

class GrupTemsilciEkleApi {
  static Future posttemsilcigrup(
    int grupid,
    int temsilciid,
  ) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/grup_temsilci_ekle?grup_id=" +
            grupid.toString() +
            "&temsilci_id=" +
            temsilciid.toString()));
  }
}
