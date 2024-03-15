import 'dart:io';

import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/model/firebase_subscription_model.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import '../../../config.dart';
import '../../../constants/firestore_constants.dart';
import '../../../home/screen/home_main_screen.dart';
import '../../../model/firebase_user_model.dart';
import '../../../model/login_model.dart';
import '../../join/screen/join_main_screen.dart';
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
      if (result.docs.isEmpty) {
        customDialog('알림', Text("존재하지 않는 계정입니다.\n회원가입 후 로그인을 진행해 주세요."), () {
          Get.to(() => JoinMainScreen());
        }, '회원가입');
      } else {
        await GoogleSignIn().signOut();
        DocumentSnapshot documentSnapshot = documents[0];
        BeautyUser user = BeautyUser.fromDocument(documentSnapshot);
        setUser(user);
        Get.off(() => HomeMainScreen());
      }
    }
  }

  Future<void> signInWithApple() async {
    bool isApple = await TheAppleSignIn.isAvailable();
    if (!isApple) {
      customDialog('안내', Text("애플 로그인을 지원하지 않는 기기입니다"), () {
        Get.back();
      }, '확인');
    } else {
      final AuthorizationResult result =
          await TheAppleSignIn.performRequests([const AppleIdRequest()]);
      String id = '';
      switch (result.status) {
        case AuthorizationStatus.authorized:
          id = result.credential?.user ?? '';
          final QuerySnapshot res = await firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .where('id', isEqualTo: id)
              .get();
          final List<DocumentSnapshot> documents = res.docs;
          if (res.docs.isEmpty) {
            customDialog('알림', Text("존재하지 않는 계정입니다.\n회원가입 후 로그인을 진행해 주세요."),
                () {
              Get.to(() => JoinMainScreen());
            }, '회원가입');
          } else {
            DocumentSnapshot documentSnapshot = documents[0];
            BeautyUser user = BeautyUser.fromDocument(documentSnapshot);
            setUser(user);
            Get.off(() => HomeMainScreen());
          }
          break;

        case AuthorizationStatus.error:
          print("Sign in failed: ${result.error?.localizedDescription}");
          break;

        case AuthorizationStatus.cancelled:
          print('User cancelled');
          break;
      }
    }
  }

  Future<void> updateUserInfo(String id) async {
    final QuerySnapshot result = await firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .where('id', isEqualTo: id)
        .get();
    final List<DocumentSnapshot> documents = result.docs;

    DocumentSnapshot documentSnapshot = documents[0];
    BeautyUser user = BeautyUser.fromDocument(documentSnapshot);
    print(user.nickName);
    setUser(user);
  }

  setUser(BeautyUser user) {
    _user = user;
    print(user.nickName);
    //로그인시 미리 구독 데이터 가져오기
    HomeController.to.updateSubscribe();
    HomeController.to.getSubscriptionChannels();
    update();
  }

  logout() {
    _user = null;
    update();
    Get.off(() => LoginReciveInfoScreen());
    BottomNavBarController.to.bottomNavCurrentIndex.value = 0;
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

  String getId() {
    return _user?.id ?? "001";
  }

  int getSubscribeCnt() {
    return _user?.subscribeCnt ?? 0;
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
