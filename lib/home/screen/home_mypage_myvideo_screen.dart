import 'package:beautyblock_app/home/local_widget/scaffold/home_mypage_myvideo_screen_scaffold.dart';
import 'package:beautyblock_app/model/firebase_post_model.dart';
import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../widget/widget_tabbar.dart';
import '../local_widget/list_item/mypage_mychannel_myvideo_listview_item.dart';

class HomeMyPageMyVideoScreen extends StatefulWidget {
  const HomeMyPageMyVideoScreen({super.key});

  @override
  State<HomeMyPageMyVideoScreen> createState() =>
      _HomeMyPageMyVideoScreenState();
}

class _HomeMyPageMyVideoScreenState extends State<HomeMyPageMyVideoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeMyPageMyVideoScreenScaffold(
      appbarSection: _buildAppBar(),
      tabBarSection: _buildTabBar(_tabController),
      bottomListviewSection: _buildListView(),
    );
  }

  Widget _buildAppBar() {
    return AppbarWidget(appbarText: '나의영상');
  }

  Widget _buildTabBar(controller) {
    List<dynamic> tabText = ["업로드 영상", "보관중 영상", "공유중인 영상"];
    final regExp = RegExp('[가-힣]+');

    return Row(
      children: [
        Flexible(
          flex: 2,
          child: IconButton(
            icon: SvgPicture.asset('assets/images/ic_filter.svg'),
            onPressed: () {},
          ),
        ),
        Expanded(
          flex: 8,
          child: TabBarWidget(
              controller: controller,
              tabs: tabText
                  .map((text) =>
                      Container(width: Get.width * 0.3, child: Tab(text: text)))
                  .toList()),
        )
      ],
    );
  }

  Widget _buildListView() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        MyPageMyChannelMyVideoListviewItem(
          post: BeautyPost(id: 'a', userId: 'a'),
          userName: 'BeautyBlock',
          userProfile: '',
        ),
      ],
    );
  }
}
