import 'dart:io';

import 'package:beautyblock_app/model/firebase_category_model.dart';
import 'package:beautyblock_app/model/firebase_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../../../constants/firestore_constants.dart';
import '../../home/screen/home_fan_screen.dart';

class FanController extends GetxController {
  static FanController get to => Get.find();
  GetConnect getConnect = GetConnect();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  List<CategoryData>? _cate;


  @override
  void onInit() {
    super.onInit();
    getCategorySync();
  }

  Future<void> getCategorySync() async {
    final QuerySnapshot result = await firebaseFirestore
          .collection(FirestoreConstants.pathCategoriesCollection)
          .get();
    final List<DocumentSnapshot> documents = result.docs;
    List<CategoryData> cateList = [];
    for (var doc in result.docs) {
      CategoryData cate = CategoryData.fromDocument(doc);
      cateList.add(cate);
    }
    setCatecory(cateList);
  }


  setCatecory(List<CategoryData> cateList) {
    _cate = cateList;
  }

  
  List<CategoryData>? getCategory(){
    return _cate;
  }
}
