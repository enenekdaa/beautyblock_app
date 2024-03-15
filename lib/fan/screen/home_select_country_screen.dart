import 'package:beautyblock_app/fan/controller/fan_controller.dart';
import 'package:beautyblock_app/fan/controller/ranking_controller.dart';
import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/screen/home_fan_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_custom_dropdown.dart';
import 'package:beautyblock_app/widget/widget_custom_group_dropdown.dart';
import 'package:beautyblock_app/widget/widget_custom_title_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config.dart';
import '../../../widget/widget_radius_button.dart';
import '../../home/main_bottom_navbar_tab/screen/tab_channel_screen.dart';
import '../../widget/widget_appbar.dart';
import '../../home/local_widget/scaffold/home_select_country_screen_scaffold.dart';

class HomeSelectCountryScreen extends StatelessWidget {
  HomeSelectCountryScreen({super.key});

  final FanController _fanController = Get.put(FanController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FanController>(builder: (controller) {
      return HomeSelectCountryScreenScaffold(
          appBarSection: _buildAppBar(),
          selectCountrySection: _buildDropDownSection(),
          bottomButtonSection: _buildBottomButton());
    });
  }

  Widget _buildAppBar() {
    return AppbarWidget(
      appbarText: "지역 및 국가 선택",
      centerTitle: true,
    );
  }

  Widget _buildDropDownSection() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: Get.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '국가(나라)선택',
                style: AppTheme.smallTitleTextStyle,
              ),
              SizedBox(
                height: Get.height * 0.005,
              ),
              CustomTitleDropDownWidget(
                  itemList: FanController.to.getCategory(),
                  dropdownKey: 'title')
            ],
          ),
        ), //Counties
        Container(
          padding: EdgeInsets.only(top: Get.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '선택확인',
                style: AppTheme.smallTitleTextStyle,
              ),
              SizedBox(
                height: Get.height * 0.005,
              ),
              Container(
                height: Get.height * 0.06,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                // 드롭다운 버튼의 내부 패딩
                decoration: BoxDecoration(
                  color: Color.fromRGBO(171, 169, 163, 0.12), // 배경색을 회색으로 설정
                  borderRadius: BorderRadius.circular(8), // 모서리를 둥글게
                ),
                child: Obx(
                  () => Text(
                      '${HomeController.to.getTitleSelectedValue('title')}',
                      style: AppTheme.smallTitleTextStyle
                          .copyWith(fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ) //selected
      ],
    );
  }

  Widget _buildBottomButton() {
    return RadiusButtonWidget(
      text: "확인",
      onPress: () => showSelectedSearchInfo(),
      backgroundColor: GlobalBeautyColor.buttonHotPink,
    );
  }

  showSelectedSearchInfo() {
    customDialog(
        '선택 확인',
        Text(
          '검색 : ${HomeController.to.selectedCategory}'
          '\n국가 : ${HomeController.to.getDropdownSelectedValue('title')}'
          '\n선택하신 항목으로 검색하시겠습니까?',
          textAlign: TextAlign.center,
        ), () {
          HomeController.to.selectCategory('Brand');
          HomeController.to.selectContinent('Asia');
          HomeController.to.selectCountryFan('${HomeController.to.getDropdownSelectedValue('title')}');
      Get.to(TabChannelScreen());
    }, "확인");
  }
}
