class Model {
  final String? id;
  final String uid;
  final String username;
  final String avatarUrl;
  final String imageUrl;
  final String caption;

  Model(
      {this.id,
      required this.uid,
      required this.username,
      required this.avatarUrl,
      required this.imageUrl,
      required this.caption});

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'uid' : uid,
      'username' : username,
      'avatarUrl' : avatarUrl,
      'imageUrl' : imageUrl,
      'caption' : caption,
    };
  }

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      uid: json['uid'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'].toString(),
      imageUrl: json['imageUrl'].toString(),
      caption: json['caption'].toString(),
    );
  }
}