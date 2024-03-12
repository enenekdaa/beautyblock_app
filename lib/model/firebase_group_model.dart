import 'package:cloud_firestore/cloud_firestore.dart';

class GroupData {
  String id = '';
  String group = '';
  GroupData(
      {required this.id,
      this.group = ''
      });

  factory GroupData.fromDocument(DocumentSnapshot doc) {
    String id = '';
    String group = '';
    try {
      id = doc.get('id');
      group = doc.get('group');
    } catch(e) {}
    return GroupData(
        id: id,
        group: group);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group': group
    };
  }

  void setId(String cateId)
  {
    id = cateId;
  }

  void setGroup(String groupIn)
  {
    group = groupIn;
  }
}
