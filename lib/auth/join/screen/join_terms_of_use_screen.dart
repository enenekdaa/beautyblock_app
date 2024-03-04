import 'package:beautyblock_app/auth/join/controller/join_controller.dart';
import 'package:beautyblock_app/auth/join/local_widget/join_terms_of_use_scaffold.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:beautyblock_app/widget/widget_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class JoinTermsOfUseScreen extends StatelessWidget {
   JoinTermsOfUseScreen({super.key});
  JoinController _joinController = Get.find();
  @override
  Widget build(BuildContext context) {
    return JoinTermsOfUseScaffold(
        middleContents: middleContents(),
        joinButton: RadiusButtonWidget(
          onPress: ()=> Get.toNamed('/receiveEmailScreen'), //todo 버튼 프레스 조인
          backgroundColor: GlobalBeautyColor.buttonHotPink,
          text: 'Join',
        ),
        inviteCodeForm: TextInputWidget(
          titleText: '초대코드(선택)',
          hintText: '초대코드를 입력해주세요.',
          isVisible: true,
          guideText: "*이벤트 및 정보 수신 동의 후 이용가능",
          guideTextColor: Color.fromRGBO(196, 196, 196, 1),
          guideTextAlign: Alignment.topCenter,
        ));
  }

  Widget middleContents() {
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

   Widget _buildTermsOfUseItem(termText, index,ftSize,ftWeight) {
     return Container(
       width: double.infinity,
       child:
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(termText,style: AppTheme.smallTitleTextStyle.copyWith(fontSize: ftSize,fontWeight: ftWeight,height: 1.4),
             ),
             Checkbox(
               value: _joinController.isChecked[index],
               onChanged: (value) {
                 if(index ==3){
                   _joinController.isChecked[index] = value!;
                   _joinController.isChecked[0]= value;
                   _joinController.isChecked[1]= value;
                   _joinController.isChecked[2]= value;
                 }else {
                   _joinController.isChecked[index] = value!;
                   _joinController.termsOfUseAllAgreeValueChanger();
                 }
               },
             ),

           ],
         ),
     );
   }

}



