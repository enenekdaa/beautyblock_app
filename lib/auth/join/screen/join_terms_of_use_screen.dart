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

  Widget _buildIviteCodeForm(){
    return TextInputWidget(
      titleText: '초대코드(선택)',
      hintText: '초대코드를 입력해주세요.',
      isGuideTextVisible: true,
      guideText: "*이벤트 및 정보 수신 동의 후 이용가능",
      guideTextColor: Color.fromRGBO(196, 196, 196, 1),
      guideTextAlign: Alignment.topCenter,
      controller: JoinController.to.inviteCodeController,
      focusNode: JoinController.to.focusNode,
    );
  }
  Widget  _buildJoinButton(){
    return RadiusButtonWidget(
        onPress: ()=> {
          if(JoinController.to.isChecked[0] && JoinController.to.isChecked[1]){
            showEventDialog(true)
          }else{
            customDialog('필수 항목 동의', Text('필수 항목을 동의 해주세요.'), (){Get.back();}, '확인')
          }
        }, //todo 버튼 프레스 조인
    backgroundColor: GlobalBeautyColor.buttonHotPink,
    text: 'Join'
    );
  }
  Widget _buildmiddleContents() {
    return Obx(()=> Column(
        children: [
          _buildTermsOfUseItem("모든 항목 동의", 3,16.0,FontWeight.w900),
          Divider(thickness: 0.5,color: Color.fromRGBO(181, 181, 181, 0.7),),
          _buildTermsOfUseItem("[필수] 서비스 이용약관 동의", 0,14.0,FontWeight.w500),
          _buildTermsOfUseItem("[필수] 서비스 개인정보 수집 및 이용 동의", 1,14.0,FontWeight.w500),
        _buildTermsOfUseItem("[선택] 이벤트 및 정보수신", 2,14.0,FontWeight.w500),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

   Container _buildTermsOfUseItem(termText, index,ftSize,ftWeight) {
     return Container(
       width: double.infinity,
       child:
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(termText,style: AppTheme.smallTitleTextStyle.copyWith(fontSize: ftSize,fontWeight: ftWeight,height: 1.4),
             ),
             Checkbox(
               value: JoinController.to.isChecked[index],
               onChanged: (value) {
                 if(index ==3){
                   JoinController.to.isChecked[index] = value!;
                   JoinController.to.isChecked[0]= value;
                   JoinController.to.isChecked[1]= value;
                   JoinController.to.isChecked[2]= value;
                 }else {
                   JoinController.to.isChecked[index] = value!;
                   JoinController.to.termsOfUseAllAgreeValueChanger();
                 }
                 if(index == 3 || index ==2){
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
         isJoinClicked ? '이벤트 및 정보수신 동의 안내' : '가입안내',
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
         isJoinClicked ? '다음' : '동의합니다.');
   }
}



