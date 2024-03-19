import 'package:beautyblock_app/auth/join/local_widget/join_app_description_Scaffold.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/screen/home_main_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../widget/widget_radius_button.dart';

class JoinAppDescriptionScreen extends StatelessWidget {
  const JoinAppDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinAppDescriptionScaffold(
      decriptionTitle: _buildTitleSection(),
      imageView: _buildImageSection(),
      appDecription: _buildAppDecription(),
      bottomButtonSection: _buildBottomButton(),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          'Beauty\nEverything, everywhere, all at once',
          style: AppTheme.smallTitleTextStyle.copyWith(fontSize: 15),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Get.height * 0.02),
        Text(
          'BeautyBlock',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              fontFamily: 'NotoSans',
              height: 1.2),
        )
      ],
    );
  }

  Widget _buildImageSection() {
    return Image.asset('assets/images/img_page_description.png');
  }

  Widget _buildAppDecription() {
    return Column(
      children: [
        Text(
          'All essential services of the beauty industry are provided in this application',
          style:
              AppTheme.smallTitleTextStyle.copyWith(fontSize: 16, height: 1.4),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Text(
          'Brands, distributors, marketers, production, media and even '
          'celebrities and influencers!\nAll of these services will be '
          'easily accessible with a click.',
          style: TextStyle(
              fontSize: 12,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.w500,
              height: 1.45,
              color: Color.fromRGBO(91, 89, 84, 1)),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _buildBottomButton() {
    return RadiusButtonWidget(
      text: "NEXT",
      onPress: () {
        Get.offAll(() => HomeMainScreen());
      },
      backgroundColor: GlobalBeautyColor.buttonHotPink,
    );
  }
}
