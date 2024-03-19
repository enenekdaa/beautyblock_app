import 'package:beautyblock_app/auth/join/controller/join_controller.dart';
import 'package:beautyblock_app/auth/join/local_widget/join_terms_of_use_scaffold.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:beautyblock_app/widget/widget_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'join_receive_email_screen.dart';

class JoinTermsOfUseScreen extends StatelessWidget {
  const JoinTermsOfUseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return JoinTermsOfUseScaffold(
      middleContents: _buildmiddleContents(),
      joinButton: _buildJoinButton(),
      inviteCodeForm: _buildIviteCodeForm(),
    );
  }

  Widget _buildIviteCodeForm() {
    return TextInputWidget(
      titleText: 'Invitation Code (Optional)',
      hintText: 'Please Enter the Invitation Code.',
      isGuideTextVisible: true,
      guideText: "*Available after Agreeing to Receive Events and Information",
      guideTextColor: Color.fromRGBO(196, 196, 196, 1),
      guideTextAlign: Alignment.topCenter,
      controller: JoinController.to.inviteCodeController,
      focusNode: JoinController.to.focusNode,
    );
  }

  Widget _buildJoinButton() {
    return RadiusButtonWidget(
        onPress: () => {
              if (JoinController.to.isChecked[0] &&
                  JoinController.to.isChecked[1])
                {showEventDialog(true)}
              else
                {
                  customDialog(
                      'Mandatory Agreement',
                      Text('Please agree to '
                          'our mandatory Terms and Conditions.'), () {
                    Get.back();
                  }, 'Confirm')
                }
            }, //todo 버튼 프레스 조인
        backgroundColor: GlobalBeautyColor.buttonHotPink,
        text: 'Join');
  }

  Widget _buildmiddleContents() {
    return Obx(
      () => Column(
        children: [
          _buildTermsOfUseItem("Agree to All", 3, 16.0, FontWeight.w900),
          Divider(
            thickness: 0.5,
            color: Color.fromRGBO(181, 181, 181, 0.7),
          ),
          _buildTermsOfUseItem("[Required] Agree to the Terms of Service", 0,
              14.0, FontWeight.w500),
          _buildTermsOfUseItem(
              "[Required] Consent to the Collection and "
              "Use of Personal Information for Service",
              1,
              14.0,
              FontWeight.w500),
          _buildTermsOfUseItem("[Optional] Receive Events and Information", 2,
              14.0, FontWeight.w500),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Container _buildTermsOfUseItem(termText, index, ftSize, ftWeight) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            termText,
            style: AppTheme.smallTitleTextStyle
                .copyWith(fontSize: ftSize, fontWeight: ftWeight, height: 1.4),
          ),
          Checkbox(
            value: JoinController.to.isChecked[index],
            onChanged: (value) {
              if (index == 3) {
                JoinController.to.isChecked[index] = value!;
                JoinController.to.isChecked[0] = value;
                JoinController.to.isChecked[1] = value;
                JoinController.to.isChecked[2] = value;
              } else {
                JoinController.to.isChecked[index] = value!;
                JoinController.to.termsOfUseAllAgreeValueChanger();
              }
              if (index == 3 || index == 2) {
                showEventDialog(false);
              }
            },
            activeColor: GlobalBeautyColor.buttonHotPink,
          ),
        ],
      ),
    );
  }

  showEventDialog(isJoinClicked) {
    customDialog(
        isJoinClicked ? '이벤트 및 정보수신 동의 안내' : 'Sign-up Guide',
        RichText(
            softWrap: true,
            text: TextSpan(children: [
              TextSpan(
                  text: '이벤트 알림을 받을 수 있는 광고성 알림 수신에 ',
                  style: AppTheme.smallTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
              JoinController.to.isChecked[2]
                  ? TextSpan(
                      text: '동의',
                      style: AppTheme.smallTitleTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: GlobalBeautyColor.buttonHotPink),
                    )
                  : TextSpan(
                      text: '미동의',
                      style: AppTheme.smallTitleTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: GlobalBeautyColor.buttonHotPink),
                    ),
              TextSpan(
                  text: ' 하셨습니다. 광고성 알림 수신 여부는 ',
                  style: AppTheme.smallTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
              TextSpan(
                  text: '내설정 > 알림설정',
                  style: AppTheme.smallTitleTextStyle.copyWith(fontSize: 12)),
              TextSpan(
                  text: '에서 변경 가능합니다.',
                  style: AppTheme.smallTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 12))
            ])),
        isJoinClicked
            ? () {
                Get.back();
                Get.to(JoinReceiveEmailScreen());
              }
            : () => Get.back(),
        isJoinClicked ? 'Next' : 'Agree');
  }
}
