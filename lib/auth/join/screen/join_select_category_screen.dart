import 'package:beautyblock_app/auth/join/controller/join_controller.dart';
import 'package:beautyblock_app/auth/join/local_widget/join_select_category_scaffold.dart';
import 'package:beautyblock_app/auth/join/screen/join_check_info_screen.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/constants/beauty_constants.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_category_button.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/widget_text_input.dart';

class JoinSelectCategoryScreen extends StatelessWidget {
  const JoinSelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinSelectCategoryScaffold(
      topTextSection: _buildTopText(),
      interestTypeSection: _buildInterestTypeContainer(),
      interestCategorySection: _buildInterestCategoryContainer(),
      interestCountrySection: _buildInterestCountryContainer(context),
      bottomButtomSection: _buildBottomButtonContainer(),
    );
  }

  Widget _buildTopText() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '내 관심 유형과 카테고리를\n선택해주세요.',
              softWrap: true,
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w900,
                height: 1.45,
                color: Color.fromRGBO(18, 17, 22, 1),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              '선택한 항목에 따라 다양한 컨텐츠를 즐기실 수 있습니다.',
              softWrap: true,
              style: AppTheme.smallTitleTextStyle
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestTypeContainer() {
    List<Widget> widgets = JoinController.to.interestTypeList.map((value) {
      return Obx(() => CategoryButtonWidget(
            text: value,
            onPress: () {
              JoinController.to.toggleInterestTypeButton(
                  JoinController.to.interestTypeList.indexOf(value));
            },
            isSelected: JoinController.to.interestTypeIsChecked[
                JoinController.to.interestTypeList.indexOf(value)],
          ));
    }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '관심유형',
                  style: AppTheme.smallTitleTextStyle,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '최대 2개까지 선택',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'NotoSans',
                      color: Color.fromRGBO(196, 196, 196, 1)),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Wrap(
              spacing: 12,
              runSpacing: 3, //수직
              children: widgets,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestCategoryContainer() {
    List<Widget> widgets = JoinController.to.interestCategoryList.map((value) {
      return Obx(() => CategoryButtonWidget(
            text: value,
            onPress: () {
              JoinController.to.toggleInterestCategoryButton(
                  JoinController.to.interestCategoryList.indexOf(value));
            },
            isSelected: JoinController.to.interestCategoryIsChecked[
                JoinController.to.interestCategoryList.indexOf(value)],
          ));
    }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '관심 카테고리',
                  style: AppTheme.smallTitleTextStyle,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '최대 3개까지 선택',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'NotoSans',
                      color: Color.fromRGBO(196, 196, 196, 1)),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Wrap(
              spacing: 12, //수평
              runSpacing: 3, //수직
              children: widgets,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestCountryContainer(BuildContext context) {
    List<Widget> widgets = JoinController.to.interestCountryList.map((value) {
      return Obx(() => CategoryButtonWidget(
            text: value,
            onPress: () {
              JoinController.to.toggleInterestCountryButton(
                  JoinController.to.interestCountryList.indexOf(value));
            },
            isSelected: JoinController.to.interestCountryIsChecked[
                JoinController.to.interestCountryList.indexOf(value)],
          ));
    }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.015,
            ),
            GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onTap: () {
                showModalBottomSheet<void>(
                    context: context,
                    // isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                          padding: EdgeInsets.fromLTRB(0, 12, 0,
                              MediaQuery.of(context).viewInsets.bottom + 12),
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                              child: Column(
                            children: BeautyConstants.continent.values
                                .expand((list) => list)
                                .toList()
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        JoinController
                                            .to.countryController.text = e;
                                        Get.back();
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 20),
                                                child: Text(e,
                                                    style: AppTheme
                                                        .smallTitleTextStyle),
                                              ),
                                              Container(
                                                  width: Get.width,
                                                  height: 2,
                                                  color: const Color.fromRGBO(
                                                      240, 240, 240, 1))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          )));
                    });
              },
              child: TextInputWidget(
                titleText: '관심 국가',
                hintText: '관심국가 입력',
                isGuideTextVisible: false,
                controller: JoinController.to.countryController,
                readOnly: true,
              ),
            ),
            // Wrap(
            //   spacing: 12,  //수평
            //   runSpacing: 3, //수직
            //   children: widgets,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonContainer() {
    return Row(
      children: [
        Expanded(
            child: RadiusButtonWidget(
                onPress: () {},
                text: '나중에 선택',
                backgroundColor: Color.fromRGBO(165, 165, 165, 1))),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: RadiusButtonWidget(
                onPress: () {
                  Get.to(JoinCheckInfoScreen());
                },
                text: '저장',
                backgroundColor: GlobalBeautyColor.buttonHotPink)),
      ],
    );
  }
}
