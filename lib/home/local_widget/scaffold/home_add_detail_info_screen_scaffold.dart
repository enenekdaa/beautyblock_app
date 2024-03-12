import 'package:beautyblock_app/widget/widget_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAddDetailInfoScaffold extends StatelessWidget {
  const HomeAddDetailInfoScaffold({
    Key? key,
    required this.homeAppbarSection,
    required this.selectViedoThumbnailSection,
    required this.selectInfoSection,
    required this.bottomButtonSection,
    required this.circularProgress
  }) : super(key: key);

  final homeAppbarSection;
  final selectViedoThumbnailSection;
  final selectInfoSection;
  final bottomButtonSection;
  final circularProgress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppbarSection,
      body: Stack(
        children:[ Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Container(
              padding: EdgeInsets.only(top: Get.height * 0.03,left: 20,right: 20,bottom: Get.height * 0.02),
              child: selectViedoThumbnailSection,
            ),
            Expanded(
              child: Container(
                color: Color.fromRGBO(246, 246, 246, 1),
                child: Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.02,left: 20,right: 20),
                  child: selectInfoSection,
                ),
              ),
            )
            ,
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color.fromRGBO(246, 246, 246, 1),
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20)
              ,child:bottomButtonSection,
              ),
            )

          ]
        ),
          circularProgress
        ]
      ),
    );
  }
}
