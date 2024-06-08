class UserModel{
  String? email;
  String? userid;

  UserModel({
    required this.email, required this.userid
  });

  UserModel.fromMap(Map<String , dynamic> map){
    email=map["email"];
    userid=map["userid"];
  }

  Map<String , dynamic> tomap(){
    return{
      "userid":userid,
      "email":email,
    };
}

}