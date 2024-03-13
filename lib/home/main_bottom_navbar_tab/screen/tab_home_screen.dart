import 'package:beautyblock_app/home/screen/home_alarm_screen.dart';
import 'package:beautyblock_app/home/screen/home_channel_detail_screen.dart';
import 'package:beautyblock_app/home/screen/home_search_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../model/firebase_user_model.dart';
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
    return GetBuilder<HomeController>(builder: (context) {
      return TabHomeScaffold(
        homeAppbarSection: _buildHomeAppbar(),
        tabBarSection: _buildTabBar(_tabController),
        subcriptionChannelListSection:
            _buildSubscriptionChannelListviewSection(),
        channelProfileSection: _buildChannelProfileSection(),
        bottomListviewSection: _buildBottomListViewSection(),
      );
    });
  }

  Widget _buildHomeAppbar() {
    if (HomeController.to.isShowSubscriptionChannel) {
      return AppBar(
        titleSpacing: 0,
        leading: GestureDetector(
            onTap: () {
              HomeController.to.toggleShowSubscriptionChannel();
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
              HomeController.to.toggleShowSubscriptionChannel();
            },
            child: SvgPicture.asset(HomeController.to.isShowSubscriptionChannel
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
    if (HomeController.to.isShowSubscriptionChannel) {
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
    for (BeautyUser element in HomeController.to.subscriptionChannels) {
      inflWidgetList.add(Padding(
        padding: EdgeInsets.only(right: Get.width * 0.04),
        child: GestureDetector(
          child: CircleAvatarWidget(
            backgroundimage: NetworkImage(element.profile),
            text: element.company,
            bottomTextIsVisible: true,
            selected: HomeController.to.selectInfluencerId == element.id &&
                HomeController.to.influencerSelected,
          ),
          onTap: () {
            HomeController.to.tapInfluencer(element);
          },
        ),
      ));
    }
    return HomeController.to.isShowSubscriptionChannel
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
    BeautyUser channel = HomeController.to.subscriptionChannels
        .where((item) => item.id == HomeController.to.selectInfluencerId)
        .first;
    return HomeController.to.influencerSelected
        ? SubscriptionProfileWidget(
            imageUrl: NetworkImage(channel.profile),
            userName: channel.company,
            subscriptionBtnOnPress: () {},
            useLikeButton: false,
            useSubscriptionCountText: false,
            channelTextOnPress: () {
              Get.to(() => HomeChannelDetailScreen(
                    id: channel.id,
                  ));
            },
            channelId: HomeController.to.selectInfluencerId,
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
                children: HomeController.to.popularPosts
                    .map(
                      (post) => TabHomeListviewItem(
                        id: post.id,
                        duration: "10:24:52",
                        videoTitle: post.title,
                        views: post.viewCnt.toString(),
                        date: post.createdAt.substring(0, 10),
                        thumbnail: post.thumbnail,
                        tags: post.tags,
                      ),
                    )
                    .toList()),
            ListView(
                scrollDirection: Axis.vertical,
                children: HomeController.to.newPosts
                    .map(
                      (post) => TabHomeListviewItem(
                        id: post.id,
                        duration: "10:24:52",
                        videoTitle: post.title,
                        views: post.viewCnt.toString(),
                        date: post.createdAt.substring(0, 10),
                        thumbnail: post.thumbnail,
                        tags: post.tags,
                      ),
                    )
                    .toList()),
            ListView(
                scrollDirection: Axis.vertical,
                children: HomeController.to.recommendPosts
                    .map(
                      (post) => TabHomeListviewItem(
                        id: post.id,
                        duration: "10:24:52",
                        videoTitle: post.title,
                        views: post.viewCnt.toString(),
                        date: post.createdAt.substring(0, 10),
                        thumbnail: post.thumbnail,
                        tags: post.tags,
                      ),
                    )
                    .toList()),
            ListView(
                scrollDirection: Axis.vertical,
                children: HomeController.to.interestPosts
                    .map(
                      (post) => TabHomeListviewItem(
                        id: post.id,
                        duration: "10:24:52",
                        videoTitle: post.title,
                        views: post.viewCnt.toString(),
                        date: post.createdAt.substring(0, 10),
                        thumbnail: post.thumbnail,
                        tags: post.tags,
                      ),
                    )
                    .toList()),
          ],
        ),
      ),
    );
  }
}
