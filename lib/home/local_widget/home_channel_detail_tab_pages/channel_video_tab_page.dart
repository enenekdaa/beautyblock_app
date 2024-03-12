import 'package:beautyblock_app/home/local_widget/list_item/tab_home_listview_item.dart';
import 'package:beautyblock_app/home/local_widget/list_item/channel_detail_video_tab_listview_item.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelVideoTabPage extends StatelessWidget {
  const ChannelVideoTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildRecommandSection(),
        _buildPopularityVideoSection(),
      ],
    );
  }

  Widget _buildRecommandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '추천',
          style:
              AppTheme.smallTitleTextStyle.copyWith(fontSize: 18, height: 1.2),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
          child: TabHomeListviewItem(
              duration: '12:22:11',
              videoTitle: '영상제목 여기래',
              views: '1.2k',
              date: '2달전'),
        ),
      ],
    );
  }

  Widget _buildPopularityVideoSection() {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '인기영상',
              style: AppTheme.smallTitleTextStyle
                  .copyWith(fontSize: 18, height: 1.2),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.01),
              child: Column(
                children: [
                  ChannelDetailVideoTabListviewItem(
                      videoText: 'NUXE',
                      followCount: '12만명',
                      contentCount: '1000'),
                  ChannelDetailVideoTabListviewItem(
                      videoText: 'NUXE',
                      followCount: '12만명',
                      contentCount: '1000'),
                  ChannelDetailVideoTabListviewItem(
                      videoText: 'NUXE',
                      followCount: '12만명',
                      contentCount: '1000'),
                  ChannelDetailVideoTabListviewItem(
                      videoText: 'NUXE',
                      followCount: '12만명',
                      contentCount: '1000'),
                  ChannelDetailVideoTabListviewItem(
                      videoText: 'NUXE',
                      followCount: '12만명',
                      contentCount: '1000'),
                  ChannelDetailVideoTabListviewItem(
                      videoText: 'NUXE',
                      followCount: '12만명',
                      contentCount: '1000'),
                  ChannelDetailVideoTabListviewItem(
                      videoText: 'NUXE',
                      followCount: '12만명',
                      contentCount: '1000'),
                ],
              ),
            ),
          ]),
    );
  }
}
