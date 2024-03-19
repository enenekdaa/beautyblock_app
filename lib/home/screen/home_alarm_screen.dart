import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_alarm_screen_scaffold.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/firebase_notification_model.dart';
import '../local_widget/list_item/home_alarm_listview_item.dart';

class HomeAlarmScreen extends StatelessWidget {
  const HomeAlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeAlarmScreenScaffold(
        appbarSection: _buildAppbar(), listviewSection: _buildListView());
  }

  Widget _buildAppbar() {
    return AppBar(
      titleSpacing: 0,
      leading: GestureDetector(
        child: Image.asset('assets/images/ic_back_arrow.png'),
        onTap: () {
          Get.back();
        },
      ),
      title: Padding(
        padding: EdgeInsets.only(left: Get.width * 0.02),
        child: Text(
          'Notification',
          style: AppTheme.boldMyPageTextStyle
              .copyWith(fontSize: 16, color: Color.fromRGBO(30, 29, 29, 1)),
        ),
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

  Widget _buildListView() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('toId', isEqualTo: LoginController.to.getId())
            .orderBy('createdAt', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData) {
            // 문서 리스트를 BeautyNotification 인스턴스 리스트로 변환
            List<BeautyNotification> notifications = snapshot.data!.docs
                .map((doc) => BeautyNotification.fromDocument(doc))
                .toList()
              ..sort((a, b) {
                DateTime dateA = DateTime.parse(b.createdAt);
                DateTime dateB = DateTime.parse(a.createdAt);
                return dateA.compareTo(dateB);
              });

            return notifications.isNotEmpty
                ? ListView(children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    ...notifications
                        .map((noti) => Column(
                              children: [
                                HomeAlarmListviewItem(
                                    postId: noti.postId,
                                    image: noti.image,
                                    alarmTitle: noti.content,
                                    uploadDate: noti.createdAt),
                                const Divider(
                                  thickness: 1,
                                  color: Color.fromRGBO(239, 239, 239, 1),
                                ),
                              ],
                            ))
                        .toList()
                  ])
                : const Center(child: Text("No notifications"));
          } else {
            return const Center(child: Text("No notifications"));
          }
        },
      ),
    );
  }
}
