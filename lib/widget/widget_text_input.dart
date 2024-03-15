import 'package:beautyblock_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    required this.titleText,
    required this.hintText,
    required this.controller,
    required this.isGuideTextVisible,
    this.guideText = "",
    this.guideTextColor = Colors.white,
    this.guideTextAlign = Alignment.topLeft,
    this.focusNode,
    this.readOnly = false,
    // this.initTextValue = ""
  });

  final titleText;
  final hintText;
  final isGuideTextVisible;
  final guideText;
  final guideTextColor;
  final guideTextAlign;
  final readOnly;
  // final initTextValue;
  final controller;
  final focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: AppTheme.smallTitleTextStyle,
        ),
        SizedBox(height: 6),
        TextFormField(
          // 1. [유효성 체크]
          // 공백일 경우 메시지 출력..
          enabled: !readOnly,
          validator: (value) => value!.isEmpty ? "필수항목입니다" : null,
          controller: controller,
          obscureText: titleText == "비밀번호" ||
                  titleText == "비밀번호 입력" ||
                  titleText == "비밀번호 확인"
              ? true
              : false,
          // initialValue: initTextValue,

          decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              // 힌트문자
              filled: true,
              fillColor: Color.fromRGBO(171, 169, 163, 0.12),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              hintStyle: TextStyle(
                  color: Color.fromRGBO(174, 173, 170, 1),
                  fontFamily: 'NotoSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.6),
              enabledBorder: OutlineInputBorder(
                // 기본 모양
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBorder: OutlineInputBorder(
                // 기본 모양
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                  // 포커스 되었을 경우 모양
                  borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(
                  // 에러 발생 시 모양
                  //   borderRadius: BorderRadius.circular(10)
                  ),
              focusedErrorBorder: OutlineInputBorder(
                  // 에러 발생 후 포커스 되었을 경우 모양
                  //   borderRadius: BorderRadius.circular(10)
                  )),
          focusNode: focusNode,
        ),
        Visibility(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              alignment: guideTextAlign,
              child: Text(guideText,
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: "NotoSansKR",
                      color: guideTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 10)),
            ),
          ),
          visible: isGuideTextVisible,
        ),
      ],
    );
  }
}
