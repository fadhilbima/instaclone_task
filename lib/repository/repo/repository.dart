import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/repository/model/model.dart';

class Repository {
  final repo = FirebaseFirestore.instance;
  Future<Model> create(Model model) async {
    return await repo
        .collection('posts')
        .add(model.toJson())
        .then((doc) {
          return Model(
            uid: doc.id,
            username: model.username,
            avatarUrl: model.avatarUrl,
            imageUrl: model.imageUrl,
            caption: model.caption,
          );
    });
  }

  Future<List<Model>> all() async {
    return await repo.collection('posts').get().then(
          (snap) {
            return snap.docs.map<Model>((t) {
              return Model(
                id: t.id,
                username: t.data()['username'].toString(),
                avatarUrl: t.data()['avatarUrl'].toString(),
                uid: t.data()['uid'].toString(),
                imageUrl: t.data()['imageUrl'].toString(),
                caption: t.data()['caption'].toString(),
              );
            }).toList();
          },
    );
  }
}