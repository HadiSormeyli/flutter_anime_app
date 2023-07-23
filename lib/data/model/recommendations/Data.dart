import 'Entry.dart';
import 'User.dart';

class Data {
  Data({
    this.malId,
    this.entry,
    this.content,
    this.user,
  });

  Data.fromJson(dynamic json) {
    malId = json['mal_id'];
    if (json['entry'] != null) {
      entry = [];
      json['entry'].forEach((v) {
        entry?.add(Entry.fromJson(v));
      });
    }
    content = json['content'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? malId;
  List<Entry>? entry;
  String? content;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mal_id'] = malId;
    if (entry != null) {
      map['entry'] = entry?.map((v) => v.toJson()).toList();
    }
    map['content'] = content;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
