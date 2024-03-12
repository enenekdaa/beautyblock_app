import 'package:cloud_firestore/cloud_firestore.dart';

const emptyList = <String>[];

class BeautyPost {
  String id = '';
  String userId = '';
  String video = '';
  String thumbnail = '';
  String category = '';
  String title = '';
  String contents = '';
  int commentCnt = 0;
  int viewCnt = 0;
  String createdAt = '';
  List<String> likes = [];
  List<String> tags = [];

  BeautyPost(
      {required this.id,
      required this.userId,
      this.video = '',
      this.thumbnail = '',
      this.category = '',
      this.title = '',
      this.contents = '',
      this.commentCnt = 0,
      this.viewCnt = 0,
      this.createdAt = '',
      this.likes = emptyList,
      this.tags = emptyList});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'video': video,
      'thumbnail': thumbnail,
      'category': category,
      'title': title,
      'contents': contents,
      'commentCnt': commentCnt,
      'viewCnt': viewCnt,
      'createdAt': createdAt,
      'tags': tags,
      'likes': likes,
    };
  }

  factory BeautyPost.fromDocument(DocumentSnapshot doc) {
    String id = '';
    String userId = '';
    String video = '';
    String thumbnail = '';
    String category = '';
    String title = '';
    String contents = '';
    int commentCnt = 0;
    int viewCnt = 0;
    String createdAt = '';
    List<String> tags = [];
    List<String> likes = [];
    try {
      id = doc.get('id');
      userId = doc.get('userId');
      video = doc.get('video');
      thumbnail = doc.get('thumbnail');
      category = doc.get('category');
      title = doc.get('title');
      contents = doc.get('contents');
      commentCnt = doc.get('commentCnt');
      viewCnt = doc.get('viewCnt');
      createdAt = doc.get('createdAt');
      doc.get('tags').forEach((data) => {tags.add(data)});
      doc.get('likes').forEach((data) => {likes.add(data)});
    } catch (e) {}
    return BeautyPost(
        id: id,
        userId: userId,
        video: video,
        thumbnail: thumbnail,
        category: category,
        title: title,
        contents: contents,
        commentCnt: commentCnt,
        viewCnt: viewCnt,
        createdAt: createdAt,
        tags: tags,
        likes: likes);
  }
}
