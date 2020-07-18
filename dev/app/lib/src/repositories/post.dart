import 'package:app/src/objects/place.dart';
import 'package:app/src/objects/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository {
  String lastPlaceId;
  DocumentSnapshot lastVisible;

  getPostByPlace({Place place, int index}) async {
    List<Post> posts = [];
    QuerySnapshot data;

    if (index == 0) {
      data = await Firestore.instance
          .collection('posts')
          .where('public', isEqualTo: true)
          .where('place_id', isEqualTo: place.id)
          .limit(5)
          .getDocuments();
      //.orderBy('created_at', descending: true)
      lastVisible = data.documents[data.documents.length - 1];
    } else {
      data = await Firestore.instance
          .collection('posts')
          .where('public', isEqualTo: true)
          .where('place_id', isEqualTo: place.id)
          .startAfterDocument(lastVisible)
          .limit(5)
          .getDocuments();
      //.orderBy('created_at', descending: true)
    }
    data.documents.forEach(
      (doc) {
        var post = Post.fromJson(doc.data);
        posts.add(post);
      },
    );
    return posts;
  }

  getAllMyPosts() {
    List<Post> posts = [];
  }
}
