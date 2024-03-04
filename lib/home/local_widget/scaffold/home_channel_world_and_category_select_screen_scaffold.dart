import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeChannelWorldAndCategorySelectScreenScaffold extends StatelessWidget {
  const HomeChannelWorldAndCategorySelectScreenScaffold({
    Key? key,
    required this.homeAppbarSection,
    required this.selectWorldSection,
    required this.selectCategorySection,
  }) : super(key: key);

  final homeAppbarSection;
  final selectWorldSection;
  final selectCategorySection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppbarSection,
      body: Column(
          children:[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: Get.height * 0.1,left: 20,right: 20,bottom: Get.height * 0.02),
                child: selectWorldSection,
              ),
            ),
            Container(
              height: Get.height * 0.4,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * 0.02,left: 20,right: 20),
                child: selectCategorySection,
              ),
            ),
          ]
      ),
    );
  }
}
