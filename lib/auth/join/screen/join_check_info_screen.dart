import 'package:beautyblock_app/auth/join/controller/join_controller.dart';
import 'package:beautyblock_app/auth/join/screen/join_app_description_screen.dart';
import 'package:beautyblock_app/auth/service/join_service.dart';
import 'package:beautyblock_app/widget/widget_category_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../config.dart';
import '../../../utils.dart';
import '../../../widget/widget_radius_button.dart';
import '../../../widget/widget_text_input.dart';
import '../../login/controller/login_controller.dart';
import '../local_widget/join_check_info_scaffold.dart';

class JoinCheckInfoScreen extends StatelessWidget {
  JoinCheckInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinCheckInfoScaffold(
        infoSection: _buildInfoContainer(),
        interestSection: _buildInterestContainer(),
        bottomButtonSection: _buildBottomButtonContainer());
  }

  Widget _buildInfoContainer() {
    return Container(
        // child: Padding(
        //   padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
        //   child: Column(
        //     children: [
        //       TextInputWidget(
        //         titleText: '이메일주소',
        //         hintText: '이메일 주소를 입력해주세요.',
        //         isGuideTextVisible: false,
        //         // initTextValue: "afhskjfshafhjkdjkfh@dfhkafhdkj",
        //         controller: JoinController.to.emailController,
        //       ),
        //       SizedBox(
        //         height: Get.height * 0.03,
        //       ),
        //       TextInputWidget(
        //         titleText: '회원명',
        //         hintText: '회원명을 입력해주세요.',
        //         isGuideTextVisible: false,
        //         // initTextValue: "blackShadow",
        //         controller: JoinController.to.nameController,
        //       ),
        //       SizedBox(
        //         height: Get.height * 0.03,
        //       ),
        //       TextInputWidget(
        //         titleText: '회사명',
        //         hintText: '회사명을 입력해주세요.',
        //         isGuideTextVisible: false,
        //         // initTextValue: "blackCompany",
        //         controller: JoinController.to.companyNameController,
        //       ),
        //     ],
        //   ),
        // ),
        );
  }

  Widget _buildInterestContainer() {
    List<String> selectedInterestList = [
      ...JoinController.to.selectedInterestTypeList,
      ...JoinController.to.selectedInterestCategoryList
    ];
    List<Widget> selectedInterestWidgetList = selectedInterestList.map((value) {
      return CategoryButtonWidget(text: value, onPress: null, isSelected: true);
    }).toList();

    Widget selectedInterestCountryButtonList = CategoryButtonWidget(
        text: JoinController.to.countryController.text,
        onPress: null,
        isSelected: true);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Interests',
              style: AppTheme.smallTitleTextStyle,
            ),
            SizedBox(
              height: 6,
            ),
            Wrap(
              spacing: 10, //수평
              runSpacing: 3, //수직
              children: selectedInterestWidgetList,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              'Country of interest',
              style: AppTheme.smallTitleTextStyle,
            ),
            SizedBox(
              height: 6,
            ),
            Wrap(
              spacing: 12, //수평
              runSpacing: 3, //수직
              children: [selectedInterestCountryButtonList],
            ),
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
                onPress: () {
                  Get.back();
                },
                text: 'Edit',
                backgroundColor: Color.fromRGBO(165, 165, 165, 1))),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: RadiusButtonWidget(
                onPress: () {
                  // JoinService().submitUserData().then(   //todo 유저데이터 전달
                  //       (value){
                  //         showJoinSuccessDialog();
                  //         JoinController.to.userModel.value = value;
                  //       }
                  //     );
                  JoinController.to.updateInterests();
                  JoinController.to.clearData();
                  JoinController.to.joinToLogin();
                  showJoinSuccessDialog();
                },
                text: 'Save',
                backgroundColor: GlobalBeautyColor.buttonHotPink)),
      ],
    );
  }

  showJoinSuccessDialog() {
    customDialog(
        'Sign up Completed',
        Text(
          'Thank you for becoming a member of BeautyBlock.\nYou can now access various services related to BeautyBlock.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: AppTheme.smallTitleTextStyle
              .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        () => {Get.offAll(() => const JoinAppDescriptionScreen())},
        'Confirm');
  }
}
