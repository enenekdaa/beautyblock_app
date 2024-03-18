import 'dart:core';
import 'dart:core';

import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/list_item/tab_fan_listview_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../auth/login/controller/login_controller.dart';
import '../../../constants/firestore_constants.dart';
import '../../../model/firebase_subscription_model.dart';
import '../../../model/firebase_user_model.dart';
import '../../../utils.dart';
import '../list_item/tab_channel_listview_item.dart';

class ChannelFanTabPage extends StatefulWidget {
  const ChannelFanTabPage(this.id, {super.key});
  final String id;
  @override
  State<ChannelFanTabPage> createState() => _ChannelFanTabPageState();
}

class _ChannelFanTabPageState extends State<ChannelFanTabPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeController.to.updateFollower();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/img_main_logo_2.png',
              height: Get.height * 0.03,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: Get.width * 0.02, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'MY FAN RANKING',
                        style: AppTheme.appBarTextStyle.copyWith(fontSize: 14),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: _buildListView(),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return FutureBuilder<List<BeautyUser>>(
        future: getFollowers(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<BeautyUser> list = snapshot.data ?? [];

              return ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: list
                    .map((channel) => TabFanListviewItem(
                        channel: channel, ranking: list.indexOf(channel)))
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('데이터를 불러오는 데 실패했습니다.'));
            }
          }
          // 데이터 로딩 중...
          return Center(child: CircularProgressIndicator());
        });
  }

  Future<List<BeautyUser>> getFollowers() async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot result = await firebaseFirestore
        .collection(FirestoreConstants.pathSubscriptionCollection)
        .where('channelId', isEqualTo: LoginController.to.getId())
        .get();
    List<BeautySubscription> tmp = [];
    for (var doc in result.docs) {
      BeautySubscription sub = BeautySubscription.fromDocument(doc);
      tmp.add(sub);
    }

    List<DocumentSnapshot> allFollowers = [];

    for (int i = 0; i < tmp.length; i += 10) {
      List<String> subset = tmp
          .sublist(i, i + 10 > tmp.length ? tmp.length : i + 10)
          .map((e) => e.userId)
          .toList();
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .where('id', whereIn: subset)
          .get();

      allFollowers.addAll(querySnapshot.docs);
    }
    List<BeautyUser> followers = [];
    for (DocumentSnapshot doc in allFollowers) {
      followers.add(BeautyUser.fromDocument(doc));
    }
    List<BeautyUser> sortList = followers.toList();
    sortList.sort((a, b) {
      return b.followCnt - a.followCnt;
    });
    return sortList;
  }
}
// Widget _buildListView(){
//   return ListView(
//     scrollDirection: Axis.vertical,
//     shrinkWrap: true,
//     children: [
//       myPageListTile('BRAND FAN RANKING',
//           SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
//       myPageListTile('브랜드 기여도 순위',
//           SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
//       myPageListTile('브랜드 홍보하기',
//           SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
//       Divider(
//         color: Color.fromRGBO(171, 169, 163, 0.24),
//       ),
//       myPageListTile('내 활동 내역',
//           SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
//       myPageListTile('내 지갑 & FAN 코인',
//           SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
//       myPageListTile('브랜드 홈페이지 방문',
//           SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
//       myPageListTile('담당자 문의하기',
//           SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
//     ],
//   );
// }
// ListTile myPageListTile(text, trailing, onPress) {
//   return ListTile(
//     dense: true,
//     title: Text(
//       text,
//       style: AppTheme.boldMyPageTextStyle,
//     ),
//     trailing: trailing,
//     onTap: onPress,
//   );
// }
