import 'package:beautyblock_app/home/local_widget/scaffold/home_mypage_favorites_channel_screen_scaffold.dart';
import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils.dart';
import '../local_widget/list_item/tab_home_listview_item.dart';

class HomeMyPageFavoritesChannelScreen extends StatelessWidget {
  const HomeMyPageFavoritesChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeMyPageFavoritesChannelScreenScaffold(
        appbarSection: _buildAppbar(),
        channelSection: _buildChannelListview(),
        bottomListviewSection: _buildFavoritesVideos());
  }

  Widget _buildAppbar(){
    return AppbarWidget(appbarText: '즐겨찾기 채널');
  }

  Widget _buildChannelListview(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _channelItem(Image.asset('assets/images/img_test_chanel.png',fit: BoxFit.cover,),"Chanel"),
              _channelItem(Image.asset('assets/images/img_test_chanel.png',fit: BoxFit.cover,),"Chanel"),
              _channelItem(Image.asset('assets/images/img_test_chanel.png',fit: BoxFit.cover,),"Chanel"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesVideos(){
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
          child: Text('즐겨찾기 영상',style:AppTheme.appBarTextStyle ,),
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
        TabHomeListviewItem(
          duration: "10:24:52",
          videoTitle: "여기가 비디오 타이들입니다. 타이틀",
          views: "234121",
          date: '1달전',
        ),
      ],
    );
  }

  Container _channelItem(image,channelName){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Get.height * 0.12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: image
            ),
          ),
          SizedBox(height: Get.height * 0.01,),
          Text(channelName)
        ],
      ),
    );
  }
}
