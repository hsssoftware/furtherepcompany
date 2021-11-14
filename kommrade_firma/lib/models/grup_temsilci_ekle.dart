class GrupTemsilciEkle {
  String status;
  String message;


  GrupTemsilciEkle(String status, String message) {
    this.status = status;
    this.message = message;
  }

  GrupTemsilciEkle.fromJson(Map json) {
    status = json["status"].toString();
    message = json["message"].toString();

  }

  Map toJson() {
    return {
      "status": status,
      "message": message
    };
  }
}
