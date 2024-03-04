import 'package:beautyblock_app/home/screen/home_channel_world_and_category_select_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config.dart';
import '../../widget/widget_radius_button.dart';

class HomeAlmostDoneScreen extends StatelessWidget {
  const HomeAlmostDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/img_world_community.png'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                child: Text('거의 완료되었습니다.',style:TextStyle(fontSize: 22, color: Color.fromRGBO(18, 17, 22, 1),fontWeight: FontWeight.w900,fontFamily: 'NotoSans',height: 1.45) ,),
              ),
              Text('더 많은 Shorts 동영상을 만들어 구독자 수 50명을\n달성하고 라이브 스트리밍 기능을 사용해 보세요.',style: AppTheme.smallTitleTextStyle,textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: RadiusButtonWidget(
            onPress: () {Get.offAll(HomeChannelWorldAndCategorySelectScreen());},
            text: '자세히 알아보기',
            backgroundColor: GlobalBeautyColor.buttonHotPink),
      ),
    );
  }
}
