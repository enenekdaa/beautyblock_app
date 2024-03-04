import 'package:beautyblock_app/home/local_widget/list_item/tab_channel_listview_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../local_widget/scaffold/tab_channel_screen_scaffold.dart';

class TabChannelScreen extends StatelessWidget {
  const TabChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabChannelScreenScaffold(
        appbarSection: _buildAppbar(),
        listviewSection: _buildListview());
  }

  Widget _buildAppbar() {
    return AppBar(
      titleSpacing: 0,
      leading: Image.asset('assets/images/ic_back_arrow.png'),
      title: Row(
        children: [
          Image.asset(
            'assets/images/img_main_logo.png',
            height: Get.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.02),
            child: Text('Brand'),
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

  Widget _buildListview() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(top: Get.height *0.02),
        scrollDirection: Axis.vertical,
        children: [
          TabChannelListviewItem(videoText: 'SANPAR', followCount: '1만명', contentCount: '2,315'),
          TabChannelListviewItem(videoText: 'SANPAR', followCount: '1만명', contentCount: '2,315'),
          TabChannelListviewItem(videoText: 'SANPAR', followCount: '1만명', contentCount: '2,315'),
          TabChannelListviewItem(videoText: 'SANPAR', followCount: '1만명', contentCount: '2,315'),
          TabChannelListviewItem(videoText: 'SANPAR', followCount: '1만명', contentCount: '2,315'),
          TabChannelListviewItem(videoText: 'SANPAR', followCount: '1만명', contentCount: '2,315'),
        ],
      ),
    );
  }
}
