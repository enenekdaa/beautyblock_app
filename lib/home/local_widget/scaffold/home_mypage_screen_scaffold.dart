import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMypageScreenScaffold extends StatelessWidget {
  const HomeMypageScreenScaffold({
    Key? key,
    required this.homeAppbarSection,
    required this.profileImgSection,
    required this.listTitleSection,
    required this.bottomButtonSection,
  }) : super(key: key);

  final homeAppbarSection;
  final profileImgSection;
  final listTitleSection;
  final bottomButtonSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppbarSection,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: Get.height * 0.2,
            padding: EdgeInsets.only(
                top: Get.height * 0.01, bottom: Get.height * 0.01),
            child: profileImgSection,
          ),
          Container(
            child: listTitleSection,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: bottomButtonSection,
          )
        ],
      ),
    );
  }
}
