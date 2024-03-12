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
  String company = '';
  String position = '';
  BeautyUser(
      {required this.id,
      this.nickName = '',
      this.profile = '',
      this.email = '',
      this.phone = '',
      this.interestCategories,
      this.interestTypes,
      this.interestCountry = '',
      this.position = '',
      this.company = ''});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickName': nickName,
      'profile': profile,
      'email': email,
      'phone': phone,
      'interestCategories': interestCategories,
      'interestTypes': interestTypes,
      'interestCountry': interestCountry,
      'position': position,
      'company': company
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
    String position = '';
    String company = '';
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
    try {
      //240312 jaesung. position(담당업무), company(회사명) 추가
      position = doc.get('position');
      company = doc.get('company');
    } catch (e) {
      position = '';
      company = '';
    }
    return BeautyUser(
        id: id,
        phone: phone,
        profile: profile,
        nickName: nickName,
        email: email,
        interestCategories: interestCategories,
        interestCountry: interestCountry,
        interestTypes: interestTypes,
        position: position,
        company: company);
  }
}
