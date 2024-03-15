import 'dart:convert';
import 'package:beautyblock_app/auth/join/screen/join_receive_email_screen.dart';
import 'package:beautyblock_app/model/firebase_user_model.dart';
import 'package:beautyblock_app/model/user_model.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../../constants/firestore_constants.dart';
import '../../../home/screen/home_main_screen.dart';
import '../../login/controller/login_controller.dart';
import '../screen/join_receive_customer_info_screen.dart';
import '../screen/join_select_category_screen.dart';

class JoinController extends GetxController {
  //240311 jaesung. firestore 추가
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final LoginController _loginController = Get.find();
  static JoinController get to => Get.find();
  BeautyUser? _user;
  //termsOfUse
  var isChecked = List<bool>.filled(4, false).obs;

  //focusNode
  FocusNode focusNode = FocusNode();

  //emailReceiver
  var isEmailValid = false.obs;

  //passwordReceiver
  var isPasswordValid = false.obs;

  //category
  var interestTypeList = [].obs;
  var interestTypeIsChecked = List<bool>.filled(9, false).obs;
  var selectedInterestTypeList = [].obs;
  var interestCategoryList = [].obs;
  var interestCategoryIsChecked = List<bool>.filled(7, false).obs;
  var selectedInterestCategoryList = [].obs;
  var interestCountryList = [].obs;
  var interestCountryIsChecked = List<bool>.filled(1, false).obs;
  var selectedInterestCountryList = [].obs;
  var countryController = TextEditingController();
  //textEditingController
  var inviteCodeController = TextEditingController();
  var emailController = TextEditingController();
  var emailCertifyController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var nameController = TextEditingController();
  var companyNameController = TextEditingController();
  var responsibilityController = TextEditingController();

  //model
  var userModel = UserModel().obs;

  //category
  void toggleInterestTypeButton(int index) {
    if (selectedInterestTypeList.length <= 1) {
      interestTypeIsChecked[index] = !interestTypeIsChecked[index];
    } else {
      interestTypeIsChecked[index] = false;
    }

    if (interestTypeIsChecked[index]) {
      if (!selectedInterestTypeList.contains(interestTypeList[index])) {
        selectedInterestTypeList.add(interestTypeList[index]);
      }
    } else {
      selectedInterestTypeList.remove(interestTypeList[index]);
    }
  }

  void toggleInterestCategoryButton(int index) {
    if (selectedInterestCategoryList.length <= 2) {
      interestCategoryIsChecked[index] = !interestCategoryIsChecked[index];
    } else {
      interestCategoryIsChecked[index] = false;
    }

    if (interestCategoryIsChecked[index]) {
      if (!selectedInterestCategoryList.contains(interestCategoryList[index])) {
        selectedInterestCategoryList.add(interestCategoryList[index]);
      }
    } else {
      selectedInterestCategoryList.remove(interestCategoryList[index]);
    }
    print('select category ${selectedInterestCategoryList}');
  }

  void toggleInterestCountryButton(int index) {
    interestCountryIsChecked[index] = !interestCountryIsChecked[index];
    if (interestCountryIsChecked[index]) {
      if (!selectedInterestCountryList.contains(interestCountryList[index])) {
        selectedInterestCountryList.add(interestCountryList[index]);
      }
    } else {
      selectedInterestCountryList.remove(interestCountryList[index]);
    }
    print('select category ${selectedInterestCountryList}');
  }

  //termsOfUse
  void termsOfUseAllAgreeValueChanger() {
    if (isChecked[0] && isChecked[1] && isChecked[2]) {
      isChecked[3] = true;
    } else {
      isChecked[3] = false;
    }
  }

  void clearData() {
    // interestTypeList = [].obs;
    interestTypeIsChecked = List<bool>.filled(9, false).obs;
    selectedInterestTypeList = [].obs;
    // interestCategoryList = [].obs;
    interestCategoryIsChecked = List<bool>.filled(7, false).obs;
    selectedInterestCategoryList = [].obs;
    // interestCountryList = [].obs;
    interestCountryIsChecked = List<bool>.filled(1, false).obs;
    selectedInterestCountryList = [].obs;

    //textEditingController
    inviteCodeController.clear();
    emailController.clear();
    emailCertifyController.clear();
    passwordController.clear();
    rePasswordController.clear();
    nameController.clear();
    companyNameController.clear();
    responsibilityController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    inviteCodeActive();
    emailController.addListener(emailValidFromString);
    passwordController.addListener(passwordValidFromString);
    interestTypeList.value = [
      "Buyer",
      "Celeb",
      "MKT",
      "Media",
      "Brand",
      "ODM",
      "Logistic",
      "Influencer",
      "Others"
    ];
    interestCategoryList.value = [
      '뷰티',
      '색조',
      '스킨케어',
      '마스크/팩',
      '선케어',
      '클렌징/필링',
      '베이스'
    ];
    interestCountryList.value = ['S.Korea'];
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.removeListener(passwordValidFromString);
    emailController.removeListener(emailValidFromString);
    focusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    responsibilityController.dispose();
    nameController.dispose();
    inviteCodeController.dispose();
    emailCertifyController.dispose();
    rePasswordController.dispose();
    companyNameController.dispose();
  }

  // Future<void> signInWithApple() async {
  //   final AuthorizationCredentialAppleID appleCredential =
  //       await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //   );
  // }

  Future<void> signInWithApple() async {
    bool isApple = await TheAppleSignIn.isAvailable();

    if (!isApple) {
      customDialog('안내', Text("애플 로그인을 지원하지 않는 기기입니다"), () {
        Get.back();
      }, '확인');
    } else {
      final AuthorizationResult result = await TheAppleSignIn.performRequests([
        const AppleIdRequest(requestedScopes: [
          Scope.email,
          Scope.fullName,
        ])
      ]);
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
            BeautyUser user = BeautyUser(
                id: id,
                email: result.credential?.email ?? 'beauty@beauty.com',
                nickName: result.credential?.fullName?.nickname ?? 'Beauty',
                profile: 'https://picsum.photos/150/150');
            signUp(user);
            signOutWithGoogle();
            LoginController.to.setUser(user);
            Get.to(() => JoinReceiveCustomerInfoScreen());
          } else {
            //이미 가입된 계정
            DocumentSnapshot documentSnapshot = documents[0];
            BeautyUser user = BeautyUser.fromDocument(documentSnapshot);
            LoginController.to.setUser(user);
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

  signUp(BeautyUser user) {
    //20240311 jaesung. sign up with Firebase
    firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(user.id)
        .set(user.toJson());
    _user = user;
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
      if (documents.isEmpty) {
        //미가입 시 가입 로직(데이터 생성 및 관심지정으로 이동)
        signUp(user);
        signOutWithGoogle();
        Get.to(() => JoinReceiveCustomerInfoScreen());
        // Get.to(() => const JoinSelectCategoryScreen());
      } else {
        //기존 아이디 있으면 홈으로 이동
        DocumentSnapshot documentSnapshot = documents[0];
        BeautyUser user = BeautyUser.fromDocument(documentSnapshot);
        LoginController.to.setUser(user);
        Get.off(() => HomeMainScreen());
      }
    }
  }

  void updateInterests() async {
    firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(_user?.id)
        .update({
      'interestTypes': selectedInterestTypeList,
      'interestCategories': selectedInterestCategoryList,
      'interestCountry': countryController.text
    });
  }

  void submitCustomerInfo() {
    if (nameController.text == '' ||
        companyNameController.text == '' ||
        responsibilityController.text == '') {
      customDialog('내용 입력', Text('누락된 내용이 있어요.'), () {
        Get.back();
      }, '확인');
    } else {
      try {
        updateCustomerInfo();
        Get.toNamed('/selectCategory');
      } catch (e) {
        print(e);
      }
    }
  }

  void updateCustomerInfo() async {
    firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(_user?.id)
        .update({
      'company': companyNameController.text,
      'nickName': nameController.text,
      'position': responsibilityController.text
    });
  }

  Future<void> signOutWithGoogle() async {
    await GoogleSignIn().signOut();
  }

  Future<void> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final url = Uri.https('graph.facebook.com', '/v2.12/me',
          {'fields': 'email, name', 'access_token': result.accessToken!.token});

      final response = await http.get(url);

      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());
    }
  }

  void emailValidFromString() async {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    isEmailValid.value = regex.hasMatch(emailController.text);
  }

  void passwordValidFromString() async {
    final regex = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
    isPasswordValid.value = regex.hasMatch(passwordController.text);
  }

  void inviteCodeActive() {
    focusNode.addListener(() {
      if (!isChecked[2] && focusNode.hasFocus) {
        customDialog(
                '초대코드 이용 안내',
                Text(
                  '이벤트 및 정보 수신에 동의 후 초대코드를 이용할 수 있어요.',
                  softWrap: true,
                ), () {
          Get.back();
        }, '확인')
            .then((_) => focusNode.unfocus());
      }
    });
  }

  void joinToLogin() {
    LoginController.to.updateUserInfo(_user?.id ?? '');
  }
}
