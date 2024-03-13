import 'package:cloud_firestore/cloud_firestore.dart';

const emptyList = <String>[];

class BeautyReply {
  String id = '';
  String userId = '';
  String profile = '';
  String nickName = '';
  String createdAt = '';
  String content = '';
  List<String> likes = emptyList;

  BeautyReply(
      {required this.id,
      required this.userId,
      this.profile = '',
      this.nickName = '',
      this.createdAt = '',
      this.content = '',
      this.likes = emptyList});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'profile': profile,
      'nickName': nickName,
      'createdAt': createdAt,
      'content': content,
      'likes': likes
    };
  }

  factory BeautyReply.fromDocument(DocumentSnapshot doc) {
    String id = '';
    String userId = '';
    String profile = '';
    String nickName = '';
    String createdAt = '';
    String content = '';
    List<String> likes = emptyList;

    try {
      id = doc.get('id');
      userId = doc.get('userId');
      profile = doc.get('profile');
      nickName = doc.get('nickName');
      createdAt = doc.get('createdAt');
      content = doc.get('content');
      doc.get('likes').forEach((data) => {likes.add(data)});
    } catch (e) {}
    return BeautyReply(
        id: id,
        userId: userId,
        profile: profile,
        nickName: nickName,
        createdAt: createdAt,
        content: content,
        likes: likes);
  }
}
