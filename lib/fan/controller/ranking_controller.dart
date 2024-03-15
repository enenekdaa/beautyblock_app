import 'dart:io';

import 'package:beautyblock_app/model/firebase_category_model.dart';
import 'package:beautyblock_app/model/firebase_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../../../constants/firestore_constants.dart';
import '../../home/screen/home_fan_screen.dart';

class RankingController extends GetxController {
  static RankingController get to => Get.find();
  GetConnect getConnect = GetConnect();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  List<BeautyUser>? _userList;


  @override
  void onInit() {
    super.onInit();
  }

  Future<List<BeautyUser>> getRanking(String contury) async {

      print('contury:: ${contury}');
    final QuerySnapshot result = await firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .where('interestCountry', isEqualTo: contury)
          .get();
    final List<DocumentSnapshot> documents = result.docs;
    List<BeautyUser> tempList = [];
    for (var doc in result.docs) {
      BeautyUser user = BeautyUser.fromDocument(doc);
      print('testest:: ${user.nickName}');
      tempList.add(user);
    }
    
    return tempList;
  }

  List<BeautyUser>? getRankingUser() {
    return _userList;
  }

  setRankingUser(List<BeautyUser> userList) {
    _userList = userList;
  }
}