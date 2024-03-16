import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../local_widget/scaffold/tab_fan_screen_scaffold.dart';

class TabFanScreen extends StatelessWidget {
  const TabFanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabFanScreenScaffold(
        appbarSection: _buildAppbar(), listviewSection: _buildListview());
  }

  Widget _buildAppbar() {
    return AppBar(
      titleSpacing: 0,
      leading: Image.asset('assets/images/ic_back_arrow.png'),
      title: Row(
        children: [
          Image.asset(
            'assets/images/img_main_logo.png',
            height: Get.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.02),
            child: Text('MY FAN RANKING'),
          ),
        ],
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

  Widget _buildListview() {
    var userNameList = ['홍길동', '나나', '마마무', '리쌍', '워너비', '베베'];

    return ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: userNameList.length,
        itemBuilder: (context, index) {
          return fanListItem(userNameList[index], index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1,
            color: Color.fromRGBO(239, 239, 239, 1),
          );
        });
    // return Text('data');
  }

  Container fanListItem(userName, index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: Get.height * 0.1,
      child: Row(
        children: [
          index <= 4 ? Text('${index + 1}') : Text(''),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            height: Get.height * 0.05,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/img_test.png'),
            ),
          ),
          Text(userName),
        ],
      ),
    );
  }
}
