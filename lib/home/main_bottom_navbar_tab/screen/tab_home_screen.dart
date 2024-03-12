import 'package:beautyblock_app/home/screen/home_alarm_screen.dart';
import 'package:beautyblock_app/home/screen/home_channel_detail_screen.dart';
import 'package:beautyblock_app/home/screen/home_search_screen.dart';
import 'package:beautyblock_app/utils.dart';
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
    return Obx(() => TabHomeScaffold(
          homeAppbarSection: _buildHomeAppbar(),
          tabBarSection: _buildTabBar(_tabController),
          subcriptionChannelListSection:
              _buildSubscriptionChannelListviewSection(),
          channelProfileSection: _buildChannelProfileSection(),
          bottomListviewSection: _buildBottomListViewSection(),
        ));
  }

  Widget _buildHomeAppbar() {
    if (HomeController.to.isShowSubscriptionChannel.value) {
      return AppBar(
        titleSpacing: 0,
        leading: GestureDetector(
            onTap: () {
              HomeController.to.isShowSubscriptionChannel.value = false;
            },
            child: Image.asset('assets/images/ic_back_arrow.png')),
        title: Row(
          children: [
            Text(
              'Subscription',
              style: AppTheme.appBarTextStyle,
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
    return AppBar(
        leadingWidth: 0,
        leading: Text(''),
        title: Container(
          width: Get.width * 0.4,
          padding: EdgeInsets.only(left: 20),
          child: Image.asset(
            'assets/images/ic_main_leading_logo_2.png',
          ),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.04),
        actions: [
          GestureDetector(
            onTap: () {
              if (HomeController.to.isShowSubscriptionChannel.value) {
                HomeController.to.influencerSelected.value = false;
              }
              HomeController.to.isShowSubscriptionChannel.value =
                  !HomeController.to.isShowSubscriptionChannel.value;
            },
            child: SvgPicture.asset(
                HomeController.to.isShowSubscriptionChannel.value
                    ? 'assets/images/ic_bookmark_active'
                        '.svg'
                    : 'assets/images/ic_bookmark_deactive'
                        '.svg'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: GestureDetector(
              child: SvgPicture.asset('assets/images/ic_bell.svg'),
              onTap: () {
                Get.to(() => const HomeAlarmScreen());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: SvgPicture.asset('assets/images/ic_search.svg'),
              onTap: () {
                Get.to(() => const HomeSearchScreen());
              },
            ),
          )
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.0),
            child: Container(
                height: 2,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    spreadRadius: 1,
                    blurRadius: 3,
                    blurStyle: BlurStyle.inner,
                  ),
                ]))));
  }

  Widget _buildTabBar(controller) {
    List<dynamic> tabText = ["인기", "신규", "추천", "관심"];
    if (HomeController.to.isShowSubscriptionChannel.value) {
      return Container();
    } else {
      return TabBarWidget(
          controller: controller,
          tabs: tabText
              .map((text) =>
                  Container(width: Get.width * 0.3, child: Tab(text: text)))
              .toList());
    }
  }

  Widget _buildSubscriptionChannelListviewSection() {
    List<Widget> inflWidgetList = [];
    HomeController.to.influencerList.forEach((element) {
      inflWidgetList.add(Padding(
        padding: EdgeInsets.only(right: Get.width * 0.04),
        child: GestureDetector(
          child: CircleAvatarWidget(
            backgroundimage: AssetImage('assets/images/img_test.png'),
            text: element,
            bottomTextIsVisible: true,
            selected: HomeController.to.selectInfluencerIndex.value ==
                    HomeController.to.influencerList.indexOf(element) &&
                HomeController.to.influencerSelected.value,
          ),
          onTap: () {
            if (HomeController.to.influencerSelected.value == false) {
              //선택 안되었으면 무조건 선택
              HomeController.to.selectInfluencerIndex.value =
                  HomeController.to.influencerList.indexOf(element);
              HomeController.to.influencerSelected.value = true;
            } else if (HomeController.to.selectInfluencerIndex.value ==
                HomeController.to.influencerList.indexOf(element)) {
              //선택 되어있는데 선택한거 다시 선택
              HomeController.to.influencerSelected.value = false;
            } else {
              //선택 되어있는데 다른거 선택
              HomeController.to.selectInfluencerIndex.value =
                  HomeController.to.influencerList.indexOf(element);
              HomeController.to.influencerSelected.value = true;
            }
          },
        ),
      ));
    });
    return HomeController.to.isShowSubscriptionChannel.value
        ? Container(
            height: Get.height * 0.13,
            margin: EdgeInsets.only(top: Get.height * 0.015),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              children: inflWidgetList,
            ))
        : SizedBox();
  }

  Widget _buildChannelProfileSection() {
    return HomeController.to.influencerSelected.value
        ? SubscriptionProfileWidget(
            imageUrl: const AssetImage('assets/images/img_test.png'),
            userName: HomeController.to
                .influencerList[HomeController.to.selectInfluencerIndex.value],
            subscriptionBtnOnPress: () {},
            isSubscription: true,
            useLikeButton: false,
            useSubscriptionCountText: false,
            channelTextOnPress: () {
              Get.to(() => const HomeChannelDetailScreen());
            },
          )
        : Container();
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
