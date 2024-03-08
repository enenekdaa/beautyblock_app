import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      color: Color.fromRGBO(174, 173, 170, 1));

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
