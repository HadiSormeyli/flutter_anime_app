class User {
  User({
      this.url, 
      this.username,});

  User.fromJson(dynamic json) {
    url = json['url'];
    username = json['username'];
  }
  String? url;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['username'] = username;
    return map;
  }

}