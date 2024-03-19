import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/firestore_constants.dart';
import 'model/firebase_user_model.dart';

class AppTheme {
  static const TextTheme textTheme = TextTheme(
    headlineLarge: mainLogoTextStyle,
    headlineSmall: smallTitleTextStyle,
    headlineMedium: loginNaviBarFont,
    titleSmall: tagTextStyle,
    titleMedium: whiteTextStyle,
    titleLarge: appBarTextStyle,
  );

  static const TextStyle mainLogoTextStyle = TextStyle(
      fontSize: 30,
      letterSpacing: 1,
      fontFamily: 'NotoSans',
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(18, 17, 22, 1));

  static const TextStyle smallTitleTextStyle = TextStyle(
    fontSize: 14,
    height: 1.6,
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.bold,
    color: GlobalBeautyColor.middleBlack,
  );

  static const TextStyle loginNaviBarFont = TextStyle(
      fontSize: 12,
      height: 1.45,
      letterSpacing: 1,
      fontFamily: 'NotoSans',
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(91, 89, 84, 1));

  static const TextStyle tagTextStyle = TextStyle(
      fontSize: 12,
      height: 1.8,
      letterSpacing: 1,
      fontFamily: 'NotoSans',
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(101, 99, 99, 1)
      // color: Color.fromRGBO(174, 173, 170, 1)
      //QA상 색상 더 진하게 요청주심. 240315
      );

  static const TextStyle whiteTextStyle = TextStyle(
      fontSize: 14,
      height: 1.5,
      fontFamily: 'NotoSans',
      letterSpacing: 1,
      fontWeight: FontWeight.w900,
      color: Colors.white);

  static const TextStyle boldMyPageTextStyle = TextStyle(
      fontSize: 15,
      height: 1.7,
      fontFamily: 'NotoSans',
      letterSpacing: 1,
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(91, 89, 84, 1));

  static const TextStyle appBarTextStyle = TextStyle(
      color: Color.fromRGBO(30, 29, 29, 1),
      fontSize: 16,
      fontFamily: 'NotoSans',
      fontWeight: FontWeight.bold,
      height: 1.45);
}

customDialog(String titleText, Widget textWidgets, onPress, buttonText) async {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              titleText,
              style: AppTheme.smallTitleTextStyle
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 20),
            textWidgets,
            SizedBox(height: 20),
            RadiusButtonWidget(
                onPress: onPress,
                text: buttonText,
                backgroundColor: GlobalBeautyColor.buttonHotPink)
          ],
        ),
      ),
    ),
  );
}

String formatDateString(String inputDate) {
  try {
    DateTime parsedDate = DateTime.parse(inputDate);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));

    if (inputDate == '') {
      return '';
    }
    // 오늘 날짜와 같은 경우
    if (parsedDate.year == today.year &&
        parsedDate.month == today.month &&
        parsedDate.day == today.day) {
      return 'Today';
    }

    // 어제 날짜와 같은 경우
    if (parsedDate.year == yesterday.year &&
        parsedDate.month == yesterday.month &&
        parsedDate.day == yesterday.day) {
      return 'Yesterday';
    }

    // 2일 전부터 10일 전까지
    int difference = today.difference(parsedDate).inDays;
    if (difference >= 2 && difference <= 10) {
      return '${difference} days ago';
    }

    // 그 이후일 경우
    return '${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}';
  } catch (e) {
    return '';
  }
}

//구독자 수 싱크 맞추는 기능
void followCountUpdate() async {
  //구독자 수 싱크 맞추기
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await firebaseFirestore
      .collection(FirestoreConstants.pathUserCollection)
      .get();
  List<BeautyUser> channels = [];
  for (DocumentSnapshot doc in querySnapshot.docs) {
    channels.add(BeautyUser.fromDocument(doc));
  }
  for (BeautyUser channel in channels) {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(FirestoreConstants.pathSubscriptionCollection)
        .where('channelId', isEqualTo: channel.id)
        .get();
    FirebaseFirestore.instance
        .collection(FirestoreConstants.pathUserCollection)
        .doc(channel.id)
        .update({'followCnt': querySnapshot.docs.length});
  }
}
