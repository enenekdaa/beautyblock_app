import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/list_item/tab_channel_listview_item.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../local_widget/scaffold/tab_channel_screen_scaffold.dart';

class TabChannelScreen extends StatelessWidget {
  const TabChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return TabChannelScreenScaffold(
          appbarSection: _buildAppbar(), listviewSection: _buildListview());
    });
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: Get.width * 0.02, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      HomeController.to.getCategoryString(),
                      style: AppTheme.appBarTextStyle.copyWith(fontSize: 14),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
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
        padding: EdgeInsets.only(top: Get.height * 0.02),
        scrollDirection: Axis.vertical,
        children: HomeController.to.filteredChannels
            .map((channel) => TabChannelListviewItem(
                  channel: channel,
                ))
            .toList(),
      ),
    );
  }
}
