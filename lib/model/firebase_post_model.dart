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
  int videoLength = 0;
  List<String> likes = [];
  List<String> tags = [];
  bool isTop = false;

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
      this.videoLength = 0,
      this.likes = emptyList,
      this.tags = emptyList,
      this.isTop = false});

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
      'videoLength': videoLength,
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
    int videoLength = 0;
    List<String> tags = [];
    List<String> likes = [];
    bool isTop = false;
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
    } catch (e) {
      viewCnt = 0;
    }
    try {
      createdAt = doc.get('createdAt');
    } catch (e) {
      createdAt = '2024-03-20 10:14:43';
    }
    try {
      doc.get('tags').forEach((data) => {tags.add(data)});
      doc.get('likes').forEach((data) => {likes.add(data)});
    } catch (e) {
      likes = [];
      tags = [];
    }
    try {
      videoLength = doc.get('videoLength');
    } catch (e) {
      videoLength = 0;
    }
    try {
      isTop = doc.get('isTop');
    } catch (e) {
      isTop = false;
    }
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
        likes: likes,
        videoLength: videoLength);
  }
}
