import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config.dart';
import '../../../widget/widget_radius_button.dart';
import '../../widget/widget_appbar.dart';
import '../local_widget/scaffold/home_select_country_screen_scaffold.dart';

class HomeSelectCountryScreen extends StatelessWidget {
  HomeSelectCountryScreen({super.key});

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
      appbarText: "Region and Country Selection",
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
              const Text(
                'Select Continent',
                style: AppTheme.smallTitleTextStyle,
              ),
              SizedBox(
                height: Get.height * 0.005,
              ),
              CustomDropDownWidget(
                  itemList: HomeController.to.continents,
                  dropdownKey: 'continent')
            ],
          ),
        ), //Continents
        Container(
          padding: EdgeInsets.only(top: Get.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Country Selection',
                style: AppTheme.smallTitleTextStyle,
              ),
              SizedBox(
                height: Get.height * 0.005,
              ),
              CustomDropDownWidget(
                  itemList: HomeController.to.countries, dropdownKey: 'country')
            ],
          ),
        ), //Counties
        Container(
          padding: EdgeInsets.only(top: Get.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confirm Selection',
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
                      '${HomeController.to.getDropdownSelectedValue('continent')}>${HomeController.to.getDropdownSelectedValue('country')}',
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
      text: "Confirm",
      onPress: () => showSelectedSearchInfo(),
      backgroundColor: GlobalBeautyColor.buttonHotPink,
    );
  }

  showSelectedSearchInfo() {
    // customDialog(
    //     '선택 확인',
    //     Text(
    //         '검색 : ${HomeController.to.selectedSearchCategory.value}'
    //             '\n지역 : ${HomeController.to.getDropdownSelectedValue('country')}'
    //             '\n국가 : ${HomeController.to.getDropdownSelectedValue('continent')}'
    //             '\n선택하신 항목으로 검색하시겠습니까?',textAlign: TextAlign.center,),
    //     (){
    //       BottomNavBarController.to.onItemTapped(1);
    //       Get.back();},
    //     "Confirm");
  }
}
