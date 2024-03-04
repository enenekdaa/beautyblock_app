import 'package:beautyblock_app/home/local_widget/scaffold/home_alarm_screen_scaffold.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../local_widget/list_item/home_alarm_listview_item.dart';

class HomeAlarmScreen extends StatelessWidget {
  const HomeAlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeAlarmScreenScaffold(
        appbarSection:_buildAppbar() ,
        listviewSection: _buildListView());
  }

  Widget _buildAppbar(){
    return AppBar(
      titleSpacing: 0,
      leading: GestureDetector(child: Image.asset('assets/images/ic_back_arrow.png'),
      onTap: (){Get.back();},
      ),
      title: Padding(
        padding: EdgeInsets.only(left: Get.width * 0.02),
        child: Text('알림',style: AppTheme.boldMyPageTextStyle.copyWith(fontSize: 16,color: Color.fromRGBO(30, 29, 29, 1)),),
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ]))),
    );
  }

  Widget _buildListView(){
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(height: Get.height * 0.02,),
          HomeAlarmListviewItem(alarmTitle: 'Chanel에서 업로드한 동영상:Chanel 립밤으로 10년 어리게 화장하는 방법', uploadDate: '2021.12.25'),
          Divider(thickness: 1,color: Color.fromRGBO(239, 239, 239, 1),),
          HomeAlarmListviewItem(alarmTitle: 'Chanel에서 업로드한 동영상:\nChanel No.5 활용하기', uploadDate: '2021.12.25'),
          Divider(thickness: 1,color: Color.fromRGBO(239, 239, 239, 1),),
          HomeAlarmListviewItem(alarmTitle: '다른 사용자가 다음 댓글에 좋아요.로 표시를 했습니다. “사용해보니 너무 좋은 것 같아요. 매일매일 쓰고 있네요. 주변분들에게 추천해야겠어요.”', uploadDate: '2021.12.25'),
          Divider(thickness: 1,color: Color.fromRGBO(239, 239, 239, 1),),
          HomeAlarmListviewItem(alarmTitle: '다른 사용자가 “Beauty Block-App 이용자 가이드" 다음 영상에 댓글을 남겼습니다. “이런 App이 있는 줄 몰랐습니다. 빨리 출시됐으면 좋겠네요."', uploadDate: '2021.12.25'),
          Divider(thickness: 1,color: Color.fromRGBO(239, 239, 239, 1),),
          HomeAlarmListviewItem(alarmTitle: 'Chanel에서 업로드한 동영상:Chanel 립밤으로 10년 어리게 화장하는 방법', uploadDate: '2021.12.25'),
          Divider(thickness: 1,color: Color.fromRGBO(239, 239, 239, 1),),
          HomeAlarmListviewItem(alarmTitle: 'Chanel에서 업로드한 동영상:\nChanel No.5 활용하기', uploadDate: '2021.12.25'),
          Divider(thickness: 1,color: Color.fromRGBO(239, 239, 239, 1),),
          HomeAlarmListviewItem(alarmTitle: '다른 사용자가 다음 댓글에 좋아요.로 표시를 했습니다. “사용해보니 너무 좋은 것 같아요. 매일매일 쓰고 있네요. 주변분들에게 추천해야겠어요.”', uploadDate: '2021.12.25'),
          Divider(thickness: 1,color: Color.fromRGBO(239, 239, 239, 1),),
          HomeAlarmListviewItem(alarmTitle: '다른 사용자가 “Beauty Block-App 이용자 가이드" 다음 영상에 댓글을 남겼습니다. “이런 App이 있는 줄 몰랐습니다. 빨리 출시됐으면 좋겠네요."', uploadDate: '2021.12.25'),
          Divider(thickness: 1,color: Color.fromRGBO(239, 239, 239, 1),),
        ],
      ),
    );
  }
}
