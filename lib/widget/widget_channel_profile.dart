import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/screen/home_channel_detail_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SubscriptionProfileWidget extends StatelessWidget {
  const SubscriptionProfileWidget({
    Key? key,
    required this.imageUrl,
    required this.userName,
    this.subscriptionBtnOnPress,
    this.useSubscriptionButton = true,
    this.isSubscription,
    this.useSubscriptionCountText = true,
    this.subscriptionCount = "1234",
    this.useGoToChannelText = true,
    this.goToChannelText = "채널보기",
    this.useLikeButton = true,
    this.likeButtonOnPress,
    this.channelTextOnPress,
  }) : super(key: key);

  final imageUrl;
  final userName;
  final subscriptionBtnOnPress;
  final useSubscriptionButton;
  final isSubscription;
  final useSubscriptionCountText;
  final subscriptionCount;
  final useGoToChannelText;
  final goToChannelText;
  final useLikeButton;
  final likeButtonOnPress;
  final channelTextOnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ProfileImage(),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    _buildProfileMiddleSection(),
                  ],
                ),
                _buildSubscriptionButton(),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget ProfileImage() {
    return Padding(
      padding: EdgeInsets.only(
          right: Get.width * 0.05,
          top: Get.height * 0.02,
          bottom: Get.height * 0.02),
      child: CircleAvatarWidget(
        backgroundimage: imageUrl,
      ),
    );
  }

  Widget _buildProfileMiddleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style:
              AppTheme.smallTitleTextStyle.copyWith(fontSize: 18, height: 1.2),
        ),
        useSubscriptionCountText
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
                child: Text(
                  subscriptionCount,
                  style: AppTheme.tagTextStyle,
                ),
              )
            : SizedBox(
                height: Get.height * 0.005,
              ),
        useGoToChannelText
            ? GestureDetector(
                child: Text(
                  '${goToChannelText} >',
                  style: AppTheme.smallTitleTextStyle
                      .copyWith(color: GlobalBeautyColor.buttonHotPink),
                ),
                onTap: channelTextOnPress,
              )
            : SizedBox(),
      ],
    );
  }

  Widget _buildSubscriptionButton() {
    return Row(
      children: [
        useSubscriptionButton
            ? InkWell(
                onTap: subscriptionBtnOnPress,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(239, 1, 141, 1),
                          Color.fromRGBO(6, 136, 255, 1)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            'assets/images/ic_subscription_bell.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          isSubscription ? '구독중' : '구독',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )))
            : Text(""),
        useLikeButton
            ? GestureDetector(
                child: SvgPicture.asset('assets/images/ic_like.svg'),
                onTap: likeButtonOnPress,
              )
            : Text('')
      ],
    );
  }
}
