import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeVideoplayerScreenScaffold extends StatelessWidget {
  const HomeVideoplayerScreenScaffold({
    Key? key,
    required this.videoSection,
    required this.videoDescriptionSection,
    required this.reviewSection,
    required this.searchSection,
  }) : super(key: key);

  final videoSection;
  final videoDescriptionSection;
  final reviewSection;
  final searchSection;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
           height: Get.height * 0.05,
           color: Colors.black,
          ),
          Container(
            height: Get.height * 0.3,
            child: Row(
              children: [
                Expanded(child: videoSection),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(child:videoDescriptionSection ,),
              ],
            ),
          ),
          Expanded(
            child: reviewSection,
            // fit: FlexFit.tight,
          ),
          Container(
            height: Get.height * 0.11,
            child:Column(
              children: [
                PreferredSize(
                    preferredSize: Size.fromHeight(4.0),
                    child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0.5,
                            blurRadius: 2,
                            offset: Offset(0, 6), // 그림자의 방향과 거리
                          ),
                        ]))),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    child: searchSection,
                  )

                )
              ],
            ) ,

          )
        ],
      ),
    );
  }
}
