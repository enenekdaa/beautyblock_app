import 'package:beautyblock_app/auth/join/local_widget/join_receive_password_scaffold.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:beautyblock_app/widget/widget_text_input.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class JoinReceivePasswordScreen extends StatelessWidget {
  const JoinReceivePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinReceivePasswordScaffold(
        receivePasswordInput: _buildReceiveInput(),
        joinButton: RadiusButtonWidget(
          text: "NEXT",
          onPress: ()=> Get.toNamed('/receiveCustomerInfo'),
          backgroundColor: GlobalBeautyColor.buttonHotPink,
        ));
  }

  Widget _buildReceiveInput(){
    return Column(
      children: [
        SizedBox(height: Get.height * 0.05,),
        TextInputWidget(titleText:'비밀번호 입력' ,
            hintText:'사용할 비밀번호 입력' ,
            isVisible:true,
            guideText: '8자리 이상, 영문자, 숫자, 특수문자',
            guideTextColor: Color.fromRGBO(196, 196, 196, 1),
        ),
        SizedBox(height: Get.height *0.05,),
        TextInputWidget(titleText:'비밀번호 확인' ,
          hintText:'비밀번호 확인' ,
          isVisible:true,
          guideText: '고객님의 소중한 개인정보를 위해 연속적인 숫자나 생일, 전화번호 등 추측하기 쉬운 개인정보 또는 아이디와 비슷한 정보를 제외하여 생성해주세요.',
          guideTextColor: Color.fromRGBO(196, 196, 196, 1),
        ),
      ],
    );
  }
}
