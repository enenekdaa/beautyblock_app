import 'package:beautyblock_app/auth/join/local_widget/join_receive_customer_info_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../config.dart';
import '../../../widget/widget_radius_button.dart';
import '../../../widget/widget_text_input.dart';

class JoinReceiveCustomerInfoScreen extends StatelessWidget {
  const JoinReceiveCustomerInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinReceiveCustomerInfoScaffold(
        receiveCustomerInfoInput: _buildReceiveInput(),
        joinButton: RadiusButtonWidget(
          text: "NEXT",
          onPress: ()=> Get.toNamed('/selectCategory'),
          backgroundColor: GlobalBeautyColor.buttonHotPink,
        ));
  }

  Widget _buildReceiveInput(){
    return Column(
      children: [
        SizedBox(height: Get.height *0.05,),
        TextInputWidget(titleText:'회원명' ,
          hintText:'회원명 입력' ,
          isVisible:true,
          guideText: '1.한문,영문만 가능합니다.\n\2.반드시 실명을 입력해주세요. 이벤트 참여시 다양한 혜택을 받으실 수 있습니다.',
          guideTextColor: Color.fromRGBO(196, 196, 196, 1),
        ),
        SizedBox(height: Get.height *0.05,),
        TextInputWidget(titleText:'회사명' ,
          hintText:'회사명 입력' ,
          isVisible:false,
        ),
        SizedBox(height: Get.height *0.05,),
        TextInputWidget(titleText:'담당업무' ,
          hintText:'담당업무 입력' ,
          isVisible:false,
        ),
      ],
    );
  }
}