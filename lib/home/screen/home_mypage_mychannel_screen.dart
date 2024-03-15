import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/home/local_widget/list_item/mypage_mychannel_myvideo_listview_item.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_mypage_mychannel_screen_scaffold.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:beautyblock_app/widget/widget_channel_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/firestore_constants.dart';
import '../../model/firebase_post_model.dart';

class HomeMyPageMyChannelScreen extends StatelessWidget {
  const HomeMyPageMyChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeMyPageMyChannelScreenScaffold(
      appbarSection: _buildAppbar(),
      channelProfileSection: _buildChannelProfile(),
      bottomListviewSection: _buildListView(),
    );
  }

  Widget _buildAppbar() {
    return AppbarWidget(appbarText: '내 채널');
  }

  Widget _buildChannelProfile() {
    return SubscriptionProfileWidget(
      channelId: LoginController.to.getId(),
      imageUrl: NetworkImage(LoginController.to.getProfile()),
      userName: LoginController.to.getNick(),
      subscriptionCount: LoginController.to.getSubscribeCnt().toString(),
      useLikeButton: false,
      useGoToChannelText: false,
      useSubscriptionButton: false,
    );
  }

  Widget _buildListView() {
    return FutureBuilder<List<BeautyPost>>(
        future: getPostData(LoginController.to.getId()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BeautyPost> posts = snapshot.data ?? [];
            posts.sort((a, b) {
              DateTime dateA = DateTime.parse(b.createdAt);
              DateTime dateB = DateTime.parse(a.createdAt);
              return dateA.compareTo(dateB);
            });
            if (posts.isEmpty) {
              return Center(
                child: Text('등록된 컨텐츠가 없습니다'),
              );
            } else {
              return ListView(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: posts.map((post) {
                    return MyPageMyChannelMyVideoListviewItem(
                      post: post,
                      userName: LoginController.to.getNick(),
                      userProfile: LoginController.to.getProfile(),
                    );
                  }).toList());
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<List<BeautyPost>> getPostData(id) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection(FirestoreConstants.pathPostCollection)
        .where('userId', isEqualTo: id)
        .get();
    List<BeautyPost> list = [];
    for (DocumentSnapshot doc in querySnapshot.docs) {
      list.add(BeautyPost.fromDocument(doc));
    }
    return list;
  }
}
