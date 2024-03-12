import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryData {
  String id = '';
  String group = '';
  String image = '';
  String title = '';
  CategoryData(
      {required this.id,
      this.group = '',
      this.image = '',
      this.title = ''});

  factory CategoryData.fromDocument(DocumentSnapshot doc) {
    String id = '';
    String group = '';
    String image = '';
    String title = '';
    try {
      id = doc.get('id');
      group = doc.get('group');
      image = doc.get('image');
      title = doc.get('title');
    } catch(e) {}
    return CategoryData(
        id: id,
        group: group,
        image: image,
        title: title);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group': group,
      'image': image,
      'title': title
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

  void setImage(String imageIn)
  {
    image = imageIn;
  }

  void setTitle(String titleIn)
  {
    title = titleIn;
  }

  
}
