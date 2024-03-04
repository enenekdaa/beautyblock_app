import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/screen/home_main_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../config.dart';
import '../../../widget/widget_radius_button.dart';
import '../../widget/widget_appbar.dart';
import '../local_widget/scaffold/home_select_country_screen_scaffold.dart';

class HomeSelectCountryScreen extends StatelessWidget {
  HomeSelectCountryScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return HomeSelectCountryScreenScaffold(
      appBarSection: _buildAppBar(),
      selectCountrySection: _buildDropDownSection(),
      bottomButtonSection: _buildBottomButton(),
    );
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
                '대륙(지역)선택',
                style: AppTheme.smallTitleTextStyle,
              ),
              SizedBox(
                height: Get.height * 0.005,
              ),
              CustomDropDownWidget(itemList: _homeController.continents, dropdownKey: 'continents')
            ],
          ),
        ), //Continents
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
              CustomDropDownWidget(itemList: _homeController.countries, dropdownKey: 'countries')
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
                      '${_homeController.getDropdownSelectedValue('continents')}>${_homeController.getDropdownSelectedValue('countries')}',
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
      onPress: () =>{Get.offAll(HomeMainScreen())},
      backgroundColor: GlobalBeautyColor.buttonHotPink,
    );
  }
}
