import 'package:beautyblock_app/home/local_widget/home_channel_detail_tab_pages/channel_fan_tab_page.dart';
import 'package:beautyblock_app/home/local_widget/home_channel_detail_tab_pages/channel_video_tab_page.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_channel_detail_screen_scaffold.dart';
import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:beautyblock_app/widget/widget_channel_profile.dart';
import 'package:beautyblock_app/widget/widget_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/firestore_constants.dart';
import '../../model/firebase_user_model.dart';
import '../controller/home_controller.dart';

class HomeChannelDetailScreen extends StatefulWidget {
  final String? id;
  const HomeChannelDetailScreen({super.key, required this.id});

  @override
  State<HomeChannelDetailScreen> createState() =>
      _HomeChannelDetailScreenState();
}

class _HomeChannelDetailScreenState extends State<HomeChannelDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  BeautyUser? channel;
  bool loadComplete = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    firestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(widget.id)
        .get()
        .then((value) {
      setState(() {
        channel = BeautyUser.fromDocument(value);
        loadComplete = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (context) {
      if (loadComplete) {
        return HomeChannelDetailScreenScaffold(
          AppbarSection: _buildAppbar(),
          profileSection: _buildProfileField(),
          tabBarSection: _buildTabBar(_tabController),
          tabPageSection: _buildBottomTabviewSection(_tabController),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _buildAppbar() {
    return AppbarWidget(
      appbarText: channel?.company ?? '',
      actions: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SvgPicture.asset('assets/images/ic_bell.svg'),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SvgPicture.asset('assets/images/ic_search.svg'),
          ),
        ),
        SizedBox(width: 20)
      ],
    );
  }

  Widget _buildProfileField() {
    return SubscriptionProfileWidget(
      imageUrl: NetworkImage(channel?.profile ?? ''),
      userName: channel?.company ?? '',
      subscriptionBtnOnPress: () {},
      subscriptionCount: channel?.subscribeCnt.toString(),
      useGoToChannelText: false,
      useLikeButton: false,
      channelId: channel?.id,
    );
  }

  Widget _buildTabBar(controller) {
    List<String> tabText = ["동영상", "라이브", "재생목록", "FAN"];
    List<Widget> tabsWidgetList = [];
    tabText.forEach((text) {
      tabsWidgetList.add(Container(
          width: Get.width * 0.3,
          child: SizedBox(width: Get.width * 0.3, child: Tab(text: text))));
    });
    return TabBarWidget(controller: controller, tabs: tabsWidgetList);
  }

  Widget _buildBottomTabviewSection(controller) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.01, left: 20, right: 20),
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
}
