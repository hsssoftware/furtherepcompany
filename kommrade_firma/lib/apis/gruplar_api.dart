import 'package:http/http.dart' as http;
import 'package:kommrade_firma/models/degiskenler.dart';

class GruplarApi {
  static Future getgrup() {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/gruplar?firma_id=" +
            Degiskenler.firmaid.toString()));
  }
}
