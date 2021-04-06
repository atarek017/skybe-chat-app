class User {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;

  User(
      {this.uid,
      this.name,
      this.email,
      this.username,
      this.status,
      this.state,
      this.profilePhoto});

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data['status'] = user.status;
    data['state'] = user.state;
    data['profilePhoto'] = user.profilePhoto;
    return data;
  }

  User.fromMap(Map<String, dynamic> mapdata) {
    this.uid = mapdata['uid'];
    this.name = mapdata['name'];
    this.email = mapdata['email'];
    this.username = mapdata['username'];
    this.status = mapdata['status'];
    this.state = mapdata['state'];
    this.profilePhoto = mapdata['profilePhoto'];
  }
}
