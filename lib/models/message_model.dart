class MessageModel {
  late String messageid;
  late String text;
  DateTime? createdon;

  MessageModel({required this.messageid, required this.text,this.createdon});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageid = map["messageid"];
    text = map["text"];
    createdon = map["createdon"].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      "messageid": messageid,
      "text": text,
      "createdon": createdon
    };
  }
}