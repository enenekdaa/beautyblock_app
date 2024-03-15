import 'package:cloud_firestore/cloud_firestore.dart';

class BeautyRanking {
  String userId = '';
  String channelId = '';
  BeautyRanking(
      {required this.userId, required this.channelId});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'channelId': channelId,
    };
  }

  factory BeautyRanking.fromDocument(DocumentSnapshot doc) {
    String userId = '';
    String channelId = '';

    try {
      userId = doc.get('userId');
      channelId = doc.get('channelId');
    } catch (e) {}
    return BeautyRanking(userId: userId, channelId: channelId);
  }
}
