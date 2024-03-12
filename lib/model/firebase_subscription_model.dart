import 'package:cloud_firestore/cloud_firestore.dart';

class BeautySubscription {
  String userId = '';
  String channelId = '';
  int type = 0;
  BeautySubscription(
      {required this.userId, required this.channelId, this.type = 0});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'channelId': channelId,
      'type': type,
    };
  }

  factory BeautySubscription.fromDocument(DocumentSnapshot doc) {
    String userId = '';
    String channelId = '';
    int type = 0;

    try {
      userId = doc.get('userId');
      channelId = doc.get('channelId');
      type = doc.get('type');
    } catch (e) {}
    return BeautySubscription(userId: userId, channelId: channelId, type: type);
  }
}
