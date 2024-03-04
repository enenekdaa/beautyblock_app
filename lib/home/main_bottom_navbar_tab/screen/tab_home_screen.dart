import 'package:beautyblock_app/home/screen/home_alarm_screen.dart';
import 'package:beautyblock_app/home/screen/home_channel_detail_screen.dart';
import 'package:beautyblock_app/home/screen/home_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../widget/widget_circle_avatar.dart';
import '../../../widget/widget_channel_profile.dart';
import '../../../widget/widget_tabbar.dart';
import '../../controller/home_controller.dart';
import '../../local_widget/list_item/tab_home_listview_item.dart';
import '../local_widget/scaffold/tab_home_screen_scaffold.dart';

class TabHomeScreen extends StatefulWidget {
  const TabHomeScreen({super.key});

  @override
  State<TabHomeScreen> createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabHomeScaffold(
      homeAppbarSection: _buildHomeAppbar(),
      tabBarSection: _buildTabBar(_tabController),
      influencerListSection: _builInfluencerListviewSection(),
      channelProfileSection: _buildChannelProfileSection(),
      bottomListviewSection: _buildBottomListViewSection(),
    );
  }

  Widget _buildHomeAppbar() {
    return AppBar(
      leadingWidth: 0,
      leading: Text(''),
      title: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Image.asset('assets/images/ic_main_leading_logo.png',),
      ),
      titleSpacing: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.04),
        actions: [
          GestureDetector(
            child: SvgPicture.asset('assets/images/ic_bookmark.svg'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: GestureDetector(
              child: SvgPicture.asset('assets/images/ic_bell.svg'),
              onTap: (){Get.to(HomeAlarmScreen());},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: SvgPicture.asset('assets/images/ic_search.svg'),
              onTap: (){Get.to(HomeSearchScreen());},
            ),
          )
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.0),
            child: Container(
              height: 2,
                decoration: BoxDecoration(
                    boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    spreadRadius:1,
                    blurRadius: 3,
                    blurStyle: BlurStyle.inner,
                  ),
                ]
                ))));
  }

  Widget _buildTabBar(controller) {
    List<dynamic> tabText = ["인기", "신규", "추천", "관심"];

    return TabBarWidget(
        controller: controller,
        tabs: tabText
            .map((text) =>
                Container(width: Get.width * 0.3, child: Tab(text: text)))
            .toList());
  }

  Widget _builInfluencerListviewSection() {
    List<Widget> inflWidgetList = [];
    _homeController.influencerList.forEach((element) {
      inflWidgetList.add(Padding(
        padding: EdgeInsets.only(right: Get.width * 0.04),
        child: GestureDetector(
          child: CircleAvatarWidget(
            backgroundimage: AssetImage('assets/images/img_test.png'),
            text: element,
            bottomTextIsVisible: true,
          ),
          onTap: () {
            _homeController.selectIfluencerIndex.value =
                _homeController.influencerList.indexOf(element);
          },
        ),
      ));
    });
    return Container(
        height: Get.height * 0.13,
        margin: EdgeInsets.only(top: Get.height * 0.015),
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: inflWidgetList,
        ));
  }

  Widget _buildChannelProfileSection() {
    return SubscriptionProfileWidget(
      imageUrl: AssetImage('assets/images/img_test.png'),
      userName: _homeController
          .influencerList[_homeController.selectIfluencerIndex.value],
      subscriptionBtnOnPress: () {},
      isSubscription: true,
      useLikeButton: false,
      useSubscriptionCountText: false,
      channelTextOnPress: (){Get.to(HomeChannelDetailScreen());},
    );
  }

  Widget _buildBottomListViewSection() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.005),
        child: TabBarView(
          controller: _tabController,
          children: [
            ListView(
              scrollDirection: Axis.vertical,
              children: [
                TabHomeListviewItem(
                  duration: "10:24:52",
                  videoTitle: "여기가 비디오 타이들입니다. 타이틀",
                  views: "234121",
                  date: '1달전',
                ),
                TabHomeListviewItem(
                  duration: "10:24:52",
                  videoTitle: "여기가 비디오 타이들입니다. 타이틀",
                  views: "234121",
                  date: '1달전',
                ),
                TabHomeListviewItem(
                  duration: "10:24:52",
                  videoTitle: "여기가 비디오 타이들입니다. 타이틀",
                  views: "234121",
                  date: '1달전',
                ),
                TabHomeListviewItem(
                  duration: "10:24:52",
                  videoTitle: "여기가 비디오 타이들입니다. 타이틀",
                  views: "234121",
                  date: '1달전',
                ),
                TabHomeListviewItem(
                  duration: "10:24:52",
                  videoTitle: "여기가 비디오 타이들입니다. 타이틀",
                  views: "234121",
                  date: '1달전',
                ),
              ],
            ),
            Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [Text("data2")],
              ),
            ),
            Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [Text("data3")],
              ),
            ),
            Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [Text("data4")],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
