import 'package:flutter/foundation.dart';

class MessageModel{
  String? messageid;
  String? createdon;
  String? text;

  MessageModel({
    required this.createdon, required this.messageid, required this.text
});

  MessageModel.frommap (Map<String, dynamic> map){
    messageid=  map["messageid"];
    createdon= map["createdon"];
    text= map["text"];
  }
  Map<String, dynamic> tomap(){
    return {
      "messageid":messageid,
      "createdon":createdon,
      "text":text

  };
}
}