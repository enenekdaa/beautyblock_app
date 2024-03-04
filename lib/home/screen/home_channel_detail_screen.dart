import 'package:beautyblock_app/home/local_widget/home_channel_detail_tab_pages/channel_fan_tab_page.dart';
import 'package:beautyblock_app/home/local_widget/home_channel_detail_tab_pages/channel_video_tab_page.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_channel_detail_screen_scaffold.dart';
import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:beautyblock_app/widget/widget_channel_profile.dart';
import 'package:beautyblock_app/widget/widget_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeChannelDetailScreen extends StatefulWidget {
  const HomeChannelDetailScreen({super.key});

  @override
  State<HomeChannelDetailScreen> createState() =>
      _HomeChannelDetailScreenState();
}

class _HomeChannelDetailScreenState extends State<HomeChannelDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeChannelDetailScreenScaffold(
        AppbarSection: _buildAppbar(),
        profileSection:_buildProfileField(),
        tabBarSection: _buildTabBar(_tabController),
        tabPageSection: _buildBottomTabviewSection(_tabController),
    );
  }

  Widget _buildAppbar() {
    return AppbarWidget(appbarText: 'Beauty Block', actions: [
      GestureDetector(
          onTap: () {},
          child: SvgPicture.asset('assets/images/ic_bell.svg')),
      GestureDetector(
          onTap: () {},
          child: SvgPicture.asset('assets/images/ic_search.svg')),
    ],);
  }
}

Widget _buildProfileField() {
  return SubscriptionProfileWidget(
    imageUrl: AssetImage('assets/images/img_test.png'),
    userName: 'Beauty Block',
    subscriptionBtnOnPress: () {},
    isSubscription: true,
    subscriptionCount: '123만',
    useGoToChannelText: false,
    useLikeButton: false,
  );
}

Widget _buildTabBar(controller) {
  List<String> tabText = ["동영상", "라이브", "재생목록", "FAN"];
  List<Widget> tabsWidgetList = [];
  tabText.forEach((text) {
    tabsWidgetList.add(Container(width: Get.width * 0.3,
        child: SizedBox(width: Get.width * 0.3, child: Tab(text: text))));
  });
  return TabBarWidget(controller: controller, tabs: tabsWidgetList);
}

  Widget _buildBottomTabviewSection(controller) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.01,left: 20,right: 20),
      child: TabBarView(
        controller: controller,
        children: [
          ChannelVideoTabPage(),
          Text('22222'),
          Text('333333'),
          ChannelFanTabPage(),
        ],
      ),
    );
  }


