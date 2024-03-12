import 'package:beautyblock_app/fan/controller/ranking_controller.dart';
import 'package:beautyblock_app/model/firebase_user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../fan/controller/fan_controller.dart';
import '../../home/main_bottom_navbar_tab/local_widget/scaffold/tab_fan_screen_scaffold.dart';
import '../../widget/widget_appbar.dart';

class HomeFanScreen extends StatelessWidget {
  HomeFanScreen({super.key});

  final RankingController _rankingController = Get.put(RankingController());



  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(builder: (controller) {
      return TabFanScreenScaffold(
        appbarSection: _buildAppbar(),
        listviewSection: FutureBuilder(
          future: RankingController.to.getRanking('Korea'),
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
                    print('testest123123:: ${userNameList?[0].nickName}');
                    return _buildListview(userNameList!);
                  }
          }),
        );
    });
  }
  
  Widget _buildAppbar(){
    return AppbarWidget(appbarText: 'MY FAN RANKING');
  }

  Widget _buildListview(List<BeautyUser> userNameList){
    
    print('456456456:: ${userNameList?[0].nickName}');

    return ListView.separated(
      padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: userNameList!.length,
        itemBuilder: (context,index){
        return fanListItem(userNameList[index],index);
    }
      ,  separatorBuilder: (BuildContext context, int index) {
      return Divider(thickness: 1,color: Color.fromRGBO(239, 239, 239, 1),);
    }
    );
    // return Text('data');
  }

  Container fanListItem(userName,index){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: Get.height * 0.1,
      child: Row(
        children: [
         index <= 4 ? Text('${index +1}'): Text(''),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            height: Get.height * 0.05,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/img_test.png'),
            ),
          ),
          Text(userName.nickName),
        ],
      ),
    );
  }
}
