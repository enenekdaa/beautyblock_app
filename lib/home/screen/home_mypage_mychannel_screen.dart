import 'package:beautyblock_app/home/local_widget/list_item/mypage_mychannel_myvideo_listview_item.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_mypage_mychannel_screen_scaffold.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:beautyblock_app/widget/widget_channel_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
    return AppbarWidget(appbarText: '내채널');
  }

  Widget _buildChannelProfile() {
    return SubscriptionProfileWidget(
      imageUrl: AssetImage('assets/images/img_test.png'),
      userName: 'Beauty Block',
      useLikeButton: false,
      useGoToChannelText: false,
      useSubscriptionButton: false,
    );
  }

  Widget _buildListView() {
    return ListView(
      padding: EdgeInsets.only(right: 20,left: 20),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        MyPageMyChannelMyVideoListviewItem(
            image:AssetImage('assets/images/img_test.png'),
           userName: 'BeautyBlock',
           videoName: 'Beauty Block Launching Festival - Heize & Dean',
           views: '123411',
           date: '2024.03.03'),
        MyPageMyChannelMyVideoListviewItem(
            image:AssetImage('assets/images/img_test.png'),
            userName: 'BeautyBlock',
            videoName: 'Beauty Block Launching Festival - Heize & Dean',
            views: '123411',
            date: '2024.03.03'),
        MyPageMyChannelMyVideoListviewItem(
            image:AssetImage('assets/images/img_test.png'),
            userName: 'BeautyBlock',
            videoName: 'Beauty Block Launching Festival - Heize & Dean',
            views: '123411',
            date: '2024.03.03'),
        MyPageMyChannelMyVideoListviewItem(
            image:AssetImage('assets/images/img_test.png'),
            userName: 'BeautyBlock',
            videoName: 'Beauty Block Launching Festival - Heize & Dean',
            views: '123411',
            date: '2024.03.03'),
      ],
    );
  }

}
