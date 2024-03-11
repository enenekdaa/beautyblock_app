import 'package:cloud_firestore/cloud_firestore.dart';

class BeautyUser {
  String id = '';
  String nickName = '';
  String phone = '';
  String email = '';
  String profile = '';
  List<String>? interestCategories = [];
  List<String>? interestTypes = [];
  String interestCountry = '';

  BeautyUser(
      {required this.id,
      this.nickName = '',
      this.profile = '',
      this.email = '',
      this.phone = '',
      this.interestCategories,
      this.interestTypes,
      this.interestCountry = ''});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickName': nickName,
      'profile': profile,
      'email': email,
      'phone': phone,
      'interestCategories': interestCategories,
      'interestTypes': interestTypes,
      'interestCountry': interestCountry
    };
  }

  factory BeautyUser.fromDocument(DocumentSnapshot doc) {
    String id = '';
    String nickName = '';
    String phone = '';
    String email = '';
    String profile = '';
    List<String>? interestCategories = [];
    List<String>? interestTypes = [];
    String interestCountry = '';
    try {
      id = doc.get('id');
      nickName = doc.get('nickName');
      phone = doc.get('phone');
      email = doc.get('email');
      profile = doc.get('profile');
      doc
          .get('interestCategories')
          .forEach((data) => {interestCategories.add(data)});
      doc.get('interestTypes').forEach((data) => {interestTypes.add(data)});
      interestCountry = doc.get('interestCountry');
    } catch (e) {}
    return BeautyUser(
        id: id,
        phone: phone,
        profile: profile,
        nickName: nickName,
        email: email,
        interestCategories: interestCategories,
        interestCountry: interestCountry,
        interestTypes: interestTypes);
  }
}
