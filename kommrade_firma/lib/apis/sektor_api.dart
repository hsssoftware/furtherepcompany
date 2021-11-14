import 'package:http/http.dart' as http;
class Sektorapi {
  static Future getsektor(){
  
    
        return http.get(Uri.parse("http://52.19.0.183:9000/api/v1/values/tr_sektorler"));
    
    
  }
}