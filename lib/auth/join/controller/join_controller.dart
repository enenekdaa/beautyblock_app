import 'dart:convert';
import 'package:beautyblock_app/auth/join/screen/join_receive_email_screen.dart';
import 'package:beautyblock_app/model/user_model.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class JoinController extends GetxController {
  static JoinController get to => Get.find();

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

  @override
  void onInit() {
    super.onInit();
    inviteCodeActive();
    emailController.addListener(emailValidFromString);
    passwordController.addListener(passwordValidFromString);
    interestTypeList.value = [
      "BUYER",
      "CELEB",
      "MKT",
      "PR",
      "OEM",
      "ODM",
      "LOGISTIC",
      "INFLUENCER",
      "OTHERS"
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
    interestCountryList.value = [
      '대한민국'
    ];
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

  Future<void> signInWithApple() async {
    final AuthorizationCredentialAppleID appleCredential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');
    }
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
}
