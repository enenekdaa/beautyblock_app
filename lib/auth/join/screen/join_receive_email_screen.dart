import 'package:beautyblock_app/auth/join/local_widget/join_receive_email_scaffold.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:beautyblock_app/widget/widget_text_input.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class JoinReceiveEmailScreen extends StatelessWidget {
  const JoinReceiveEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinReceiveEmailScaffold(
        middleContents: TextInputWidget(
          titleText: '사용할 이메일 주소를 입력해 주세요.',
          hintText: '이메일 주소를 입력해 주세요.',
          isVisible: true,   //todo 이메일 형식에 맞게 on/off
          guideText: '*이메일 형식에 맞춰서 입력해 주세요.',
          guideTextColor: Color.fromRGBO(255, 46, 46, 1),
        ),
        joinButton: RadiusButtonWidget(
          onPress: ()=>Get.toNamed('/certifyScreen'),  //todo onpress
          text: 'NEXT',
          backgroundColor: GlobalBeautyColor.buttonHotPink,
        )
    );
  }
}
