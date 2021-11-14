class TalepEkleModel {
  String status;
  String message;


  TalepEkleModel(String status, String message) {
    this.status = status;
    this.message = message;
  }

  TalepEkleModel.fromJson(Map json) {
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
