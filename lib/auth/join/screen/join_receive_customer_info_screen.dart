import 'package:beautyblock_app/auth/join/controller/join_controller.dart';
import 'package:beautyblock_app/auth/join/local_widget/join_receive_customer_info_scaffold.dart';
import 'package:beautyblock_app/constants/beauty_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config.dart';
import '../../../utils.dart';
import '../../../widget/widget_radius_button.dart';
import '../../../widget/widget_text_input.dart';

class JoinReceiveCustomerInfoScreen extends StatelessWidget {
  JoinReceiveCustomerInfoScreen({super.key});

  final JoinController _joinController = Get.find();

  @override
  Widget build(BuildContext context) {
    return JoinReceiveCustomerInfoScaffold(
        receiveCustomerInfoInput: _buildReceiveInput(context),
        joinButton: RadiusButtonWidget(
          text: "NEXT",
          onPress: () {
            _joinController.submitCustomerInfo();
          },
          backgroundColor: GlobalBeautyColor.buttonHotPink,
        ));
  }

  Widget _buildReceiveInput(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.05,
        ),
        TextInputWidget(
          titleText: '회원명',
          hintText: '회원명 입력',
          isGuideTextVisible: true,
          guideText:
              '1.한문,영문만 가능합니다.\n\2.반드시 실명을 입력해주세요. 이벤트 참여시 다양한 혜택을 받으실 수 있습니다.',
          guideTextColor: Color.fromRGBO(196, 196, 196, 1),
          controller: _joinController.nameController,
        ),
        SizedBox(
          height: Get.height * 0.05,
        ),
        TextInputWidget(
          titleText: '회사명',
          hintText: '회사명 입력',
          isGuideTextVisible: false,
          controller: _joinController.companyNameController,
        ),
        SizedBox(
          height: Get.height * 0.05,
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
                        children: BeautyConstants.positions
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    JoinController
                                        .to.responsibilityController.text = e;
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0, horizontal: 20),
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
            titleText: '담당업무',
            hintText: '담당업무 입력',
            isGuideTextVisible: false,
            controller: _joinController.responsibilityController,
            readOnly: true,
          ),
        ),
      ],
    );
  }
}
