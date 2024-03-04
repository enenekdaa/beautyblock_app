import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/widget_appbar.dart';

class JoinReceiveEmailScaffold extends StatelessWidget {
  const JoinReceiveEmailScaffold({
    Key? key,
    required this.middleContents,
    required this.joinButton,
  }) : super(key: key);

  final middleContents;
  final joinButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(appbarText: "회원가입"),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: Get.height* 0.1),
                child: middleContents
              ),
              joinButton
            ],
          ),
        ),
      ),
    );
  }
}