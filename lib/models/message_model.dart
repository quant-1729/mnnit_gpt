class MessageModel {
  late String messageid;
  late String text;
  DateTime? createdon;
  late String sender;

  MessageModel({required this.messageid, required this.text,this.createdon, required this.sender});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageid = map["messageid"];
    text = map["text"];
    createdon = map["createdon"].toDate();
    sender= map["sender"];
  }

  Map<String, dynamic> toMap() {
    return {
      "messageid": messageid,
      "text": text,
      "createdon": createdon,
      "sender": sender
    };
  }
}