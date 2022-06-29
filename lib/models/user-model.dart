class UserModel {
  String? uid;
  String? email;
  String? password;
  String? username;

  UserModel({this.email, this.password, this.uid, this.username});

  //reciveing the data from the server

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
    );
  }

  //sending the data to the server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'password': password,
      'username': username,
      'email': email,
    };
  }
}
