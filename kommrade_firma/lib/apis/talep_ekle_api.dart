import 'package:http/http.dart' as http;

class TalepEkleApi {
  static Future posttalep(
      int firmaid,
      int pozisyonid,
      String aciklama,
      DateTime bastar,
      DateTime bittar,
      int ilantipi,
      int ulkeid,
      int ilid,
      int ticaretturu,
      int tecrube) {
    return http.post(Uri.parse(
        "http://52.19.0.183:9000/api/v1/values/talepekle?firma_id=" +
            firmaid.toString() +
            "&pozisyon_id=" +
            pozisyonid.toString() +
            "&aciklama=" +
            aciklama.toString() +
            "&bas_tar=" +
            bastar.toString() +
            "&bit_tar=" +
            bittar.toString() +
            "&ilan_tipi=" +
            ilantipi.toString() +
            "&ulke_id=" +
            ulkeid.toString() +
            "&il_id=" +
            ilid.toString() +
            "&ticaret_turu=" +
            ticaretturu.toString() +
            "&tecrube=" +
            tecrube.toString()));
  }
}
