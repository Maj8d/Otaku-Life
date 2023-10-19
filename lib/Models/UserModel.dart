class UserModel {
  UserModel({
      this.userId, 
      this.userName, 
      this.userPassword, 
      this.userEmail, 
      this.userImage,});

  UserModel.fromJson(dynamic json) {
    userId = json['userId'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userEmail = json['userEmail'];
    userImage = json['userImage'];
  }
  int? userId;
  String? userName;
  String? userPassword;
  String? userEmail;
  String? userImage;
  UserModel copyWith({  int? userId,
  String? userName,
  String? userPassword,
  String? userEmail,
  String? userImage,
}) => UserModel(  userId: userId ?? this.userId,
  userName: userName ?? this.userName,
  userPassword: userPassword ?? this.userPassword,
  userEmail: userEmail ?? this.userEmail,
  userImage: userImage ?? this.userImage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['userName'] = userName;
    map['userPassword'] = userPassword;
    map['userEmail'] = userEmail;
    map['userImage'] = userImage;
    return map;
  }



}