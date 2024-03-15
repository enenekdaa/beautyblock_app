import 'package:cloud_firestore/cloud_firestore.dart';

const emptyList = <String>[];

class BeautyNotification {
  //알림 받은 사람 id
  String toId = '';
  //알림 유발자(댓글 알람일 경우 작성자, 신규 게시글 알람일 경우 채널 게시자)
  String fromId = '';
  //썸네일 이미지
  String image = '';
  //알림 내용
  String content = '';
  //보낸날짜
  String createdAt = '';
  //type (아직 안씀). 댓글 reply / 게시글 : post / 추가 가능
  String type = '';
  String postId = '';

  BeautyNotification(
      {required this.toId,
      this.fromId = '',
      this.image = '',
      this.content = '',
      this.createdAt = '',
      this.type = '',
      this.postId = ''});

  Map<String, dynamic> toJson() {
    return {
      'toId': toId,
      'fromId': fromId,
      'image': image,
      'createdAt': createdAt,
      'content': content,
      'type': type,
      'postId': postId
    };
  }

  factory BeautyNotification.fromDocument(DocumentSnapshot doc) {
    //알림 받은 사람 id
    String toId = '';
    //알림 유발자(댓글 알람일 경우 작성자, 신규 게시글 알람일 경우 채널 게시자)
    String fromId = '';
    //썸네일 이미지
    String image = '';
    //알림 내용
    String content = '';
    //보낸날짜
    String createdAt = '';
    //type (아직 안씀). 댓글 reply / 게시글 : post / 추가 가능
    String type = '';
    String postId = '';

    try {
      toId = doc.get('toId');
      fromId = doc.get('fromId');
      image = doc.get('image');
      content = doc.get('content');
      createdAt = doc.get('createdAt');
      type = doc.get('type');
      postId = doc.get('postId');
    } catch (e) {
      print(e);
    }

    return BeautyNotification(
        toId: toId,
        fromId: fromId,
        image: image,
        createdAt: createdAt,
        content: content,
        type: type,
        postId: postId);
  }
}
