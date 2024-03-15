import 'package:beautyblock_app/fan/controller/ranking_controller.dart';
import 'package:beautyblock_app/model/firebase_user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../fan/controller/fan_controller.dart';
import '../../home/main_bottom_navbar_tab/local_widget/scaffold/tab_fan_screen_scaffold.dart';
import '../../widget/widget_appbar.dart';
import '../controller/home_controller.dart';
import '../local_widget/list_item/tab_channel_listview_item.dart';

class HomeFanScreen extends StatelessWidget {
  HomeFanScreen({super.key});

  final RankingController _rankingController = Get.put(RankingController());



  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(builder: (controller) {
      return TabFanScreenScaffold(
        appbarSection: _buildAppbar(),
        listviewSection: FutureBuilder(
          future: RankingController.to.getRanking(HomeController.to.getTitleSelectedValue('title')??'S.Korea'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
                    return CircularProgressIndicator(); // CircularProgressIndicator : 로딩 에니메이션
                  }
                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
                  // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 부분
                  else {
                    List<BeautyUser>? userNameList=snapshot.data;
                    if(userNameList!.isEmpty)
                    {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '데이터가 없습니다.', // 에러명을 텍스트에 뿌려줌
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }
                    return _buildListview();
                  }
          }),
        );
    });
  }
  
  Widget _buildAppbar(){
    return AppbarWidget(appbarText: 'MY FAN RANKING');
  }


  Widget _buildListview() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(top: Get.height * 0.02),
        scrollDirection: Axis.vertical,
        children: HomeController.to.filteredChannels
            .map((channel) => TabChannelListviewItem(
                  channel: channel,
                ))
            .toList(),
      ),
    );
  }
}
