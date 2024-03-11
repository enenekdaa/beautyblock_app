import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config.dart';
import '../../../constants/firestore_constants.dart';
import '../../../home/screen/home_main_screen.dart';
import '../../../model/firebase_user_model.dart';
import '../../../model/login_model.dart';
import '../login_recive_info_screen.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  GetConnect getConnect = GetConnect();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  BeautyUser? _user;
  //Login
  var passwordController = TextEditingController();
  var userIdController = TextEditingController();

  Future<String> loginApp() async {
    Login login = Login(
        password: passwordController.text, userName: userIdController.text);

    final response = await getConnect.post('${Server.baseUrl}/api/login', {
      "password": 'qaz1234',
      "userName": 'test112@aaaa.com'
    }, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print(response.request!.bodyBytes);

    print(response.statusCode);
    print(response.body);
    var token = response.body['token'];
    print(token);
    return token;
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');
      BeautyUser user = BeautyUser(
          id: googleUser.id,
          email: googleUser.email,
          nickName: googleUser.displayName ?? 'Beauty',
          profile: googleUser.photoUrl ?? '');
      final QuerySnapshot result = await firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .where('id', isEqualTo: user.id)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      DocumentSnapshot documentSnapshot = documents[0];
      user = BeautyUser.fromDocument(documentSnapshot);
      setUser(user);
      Get.off(HomeMainScreen());
    }
  }

  setUser(BeautyUser user) {
    _user = user;
  }

  logout() {
    _user = null;
    Get.off(LoginReciveInfoScreen());
  }

  String getProfile() {
    return _user?.profile ?? '';
  }

  String getEmail() {
    return _user?.email ?? 'beauty@gmail.com';
  }

  String getNick() {
    return _user?.nickName ?? '뷰티블록';
  }

  void setProfile() async {
    ImagePicker imagePicker = ImagePicker();
    File? imagePath;
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 1024, imageQuality: 100);
    if (pickedFile != null) {
      imagePath = File(pickedFile.path);
      uploadPhoto(imagePath);
    }
  }

  Future uploadPhoto(File imagePath) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String path = "profile";
    UploadTask uploadTask = uploadFirebase(path, imagePath, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      String profileUrl = await snapshot.ref.getDownloadURL();
      firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .doc(_user?.id)
          .update({
        'profile': profileUrl,
      });
      _user?.profile = profileUrl;
      update();
    } on FirebaseException catch (e) {}
  }

  UploadTask uploadFirebase(String path, File image, String fileName) {
    Reference reference = firebaseStorage.ref(path).child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }
}
