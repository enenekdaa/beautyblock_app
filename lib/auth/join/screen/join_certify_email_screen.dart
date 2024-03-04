import 'package:beautyblock_app/auth/join/local_widget/join_certify_email_scaffold.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:beautyblock_app/widget/widget_text_input.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class JoinCertifyEmailScreen extends StatelessWidget {
  const JoinCertifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinCertifyEmailScaffold(
      imageContainer: _buildImageContainer(),
        messageToInform: _buildMessageToInform(),
        joinButton: _buildNextButton(),
        receiveCertifyNumInput: _buildReceiveCertifyInput(),
        reSendButton: _buildReSendButton(),
    );
  }
  
  Widget _buildImageContainer() {
    return Column(
      children: [
        SizedBox(height: Get.height *0.04),
        Stack(
          children: [
            Image.asset('assets/images/img_email.png',fit: BoxFit.cover,height: Get.height *0.34,),
            Positioned(
                bottom: -5,
                child:
                Text('인증 메일이 발송되었습니다.', style: TextStyle(fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'NatoSans',
                    height: 1.45),)
            ),
          ],
        ),
        SizedBox(height: 20,)
      ],
    );
  }

  Widget _buildMessageToInform() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('이메일==== ==== ==== ====  === === ==== 으로 발송된 인증메일을 확인해주세요.',softWrap: true,style: AppTheme.smallTitleTextStyle,textAlign: TextAlign.center,),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('메일발송은 ',style: AppTheme.smallTitleTextStyle,),
            Text('10분',style: AppTheme.smallTitleTextStyle.copyWith(color:Color.fromRGBO(239, 1, 141, 1)),),
            Text(' 후 만료됩니다.',style: AppTheme.smallTitleTextStyle,)
          ],
        )
      ],
    );
  }

  Widget _buildReceiveCertifyInput() {
    return TextInputWidget(titleText: '', hintText: '인증번호 입력', isVisible: false);
  }

  Widget _buildNextButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:20 ,horizontal: 20),
      child: Stack(
        children:[ RadiusButtonWidget(onPress:()=> Get.toNamed('/receivePasswordScreen') ,
            text: "NEXT",
            backgroundColor: GlobalBeautyColor.buttonHotPink),
    ]
      ),
    );
  }

  Widget _buildReSendButton(){
  return GestureDetector(child: Text('메일 재발송', style: AppTheme.loginNaviBarFont.copyWith(decoration: TextDecoration.underline,)),onTap: (){},);

  }
}


