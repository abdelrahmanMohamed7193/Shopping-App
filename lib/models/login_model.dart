class ShopLoginModel{
 bool? status;
 String? message ;
UserData? data  ;

ShopLoginModel.fromJson(Map<String, dynamic>json )
{
  status=json["status"];
  message=json["message"];
  data=json["data"]!= null? UserData.fromJson(json["data"]): null;

}

}

class UserData{
int? id;
 String? name;
 String? phone;
 String? email;
String?image;
int?points;
int?credit;
String?token;

// UserData({
//   this.id ,
//   required this.name ,
//   this.phone ,
//   this.email ,
//   this.image ,
//   this.points ,
//   this.credit ,
//   this.token ,
// }) ;

UserData.fromJson(Map<String, dynamic>json )
{
id=json["id"];
name=json["name"];
phone=json["phone"];
email=json["email"];
image=json["image"];
points=json["points"];
credit=json["credit"];
token=json["token"];
}


}