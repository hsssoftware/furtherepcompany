import 'package:http/http.dart' as http;

class TalepTipGuncelleApi {
  static Future updatetalep(int talepid, int taleptipi) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/taleptipiguncelle?talep_id=" +
            talepid.toString() +
            "&talep_tipi=" +
            taleptipi.toString()));
  }
}
