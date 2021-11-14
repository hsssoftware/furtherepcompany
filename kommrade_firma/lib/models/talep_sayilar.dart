class TalepSayilarModel {
  int yayinsay;
  int pasifsay;
  int taslaksay;
  int arsivsay;

  TalepSayilarModel(int yayinsay, int pasifsay, int taslaksay, int arsivsay) {
    this.yayinsay = yayinsay;
    this.pasifsay = pasifsay;
    this.taslaksay = taslaksay;
    this.arsivsay = arsivsay;
  }

  TalepSayilarModel.fromJson(Map json) {
    yayinsay = json["YAYIN_SAY"];
    pasifsay = json["PASIF_SAY"];
    taslaksay = json["TASLAK_SAY"];
    arsivsay = json["ARSIV_SAY"];
  }

  Map toJson() {
    return {
      "yayinsay": yayinsay,
      "pasifsay": pasifsay,
      "taslaksay": taslaksay,
      "arsivsay": arsivsay
    };
  }
}
