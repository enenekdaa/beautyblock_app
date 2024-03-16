import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/screen/home_channel_detail_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../home/controller/home_controller.dart';

class SubscriptionProfileWidget extends StatelessWidget {
  const SubscriptionProfileWidget({
    Key? key,
    required this.imageUrl,
    required this.userName,
    this.subscriptionBtnOnPress,
    this.useSubscriptionButton = true,
    this.useSubscriptionCountText = true,
    this.subscriptionCount = "1234",
    this.useGoToChannelText = true,
    this.goToChannelText = "채널보기",
    this.useLikeButton = true,
    this.likeButtonOnPress,
    this.channelTextOnPress,
    this.channelId,
    this.moveToChannelOnTap = false,
  }) : super(key: key);

  final imageUrl;
  final userName;
  final subscriptionBtnOnPress;
  final useSubscriptionButton;
  final useSubscriptionCountText;
  final subscriptionCount;
  final useGoToChannelText;
  final goToChannelText;
  final useLikeButton;
  final likeButtonOnPress;
  final channelTextOnPress;
  final channelId;
  final bool moveToChannelOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (moveToChannelOnTap) {
          Get.to(() => HomeChannelDetailScreen(id: channelId));
        }
      },
      child: Container(
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
    return GetBuilder<HomeController>(builder: (controller) {
      return Row(
        children: [
          useSubscriptionButton
              ? InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: Get.context!,
                        // isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Container(
                              padding: EdgeInsets.fromLTRB(
                                  0,
                                  12,
                                  0,
                                  MediaQuery.of(context).viewInsets.bottom +
                                      12),
                              color: Colors.transparent,
                              child: SingleChildScrollView(
                                  child: Column(
                                children: ['구독', '알림취소', '구독취소']
                                    .map((e) => GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () async {
                                            if (e == '구독') {
                                              if (controller
                                                      .getSubscriptionStatus(
                                                          channelId) ==
                                                  0) {
                                                Future.delayed(Duration(
                                                        milliseconds: 500))
                                                    .then((value) {
                                                  customDialog(
                                                      '알림',
                                                      Text('이미 구독 중인 '
                                                          '채널 입니다.'), () {
                                                    Get.back();
                                                  }, '확인');
                                                });
                                              } else {
                                                controller.changeSubscribe(
                                                    type: 0,
                                                    targetId: channelId);
                                              }
                                            } else if (e == '알림취소') {
                                              controller.changeSubscribe(
                                                  type: 1, targetId: channelId);
                                            } else {
                                              controller.changeSubscribe(
                                                  type: 2, targetId: channelId);
                                            }
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 20),
                                                    child: Text(e,
                                                        style: AppTheme
                                                            .smallTitleTextStyle),
                                                  ),
                                                  Container(
                                                      width: Get.width,
                                                      height: 2,
                                                      color:
                                                          const Color.fromRGBO(
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
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      decoration:
                          controller.getSubscriptionStatus(channelId) == 2
                              ? BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30),
                                )
                              : BoxDecoration(
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
                          if (controller.isSubscribe(channelId))
                            SvgPicture.asset((controller
                                        .getSubscriptionStatus(channelId) ==
                                    0
                                ? 'assets/images/ic_subscription_bell_on'
                                    '.svg'
                                : 'assets/images/ic_subscription_bell_off.svg')),
                          if (controller.isSubscribe(channelId))
                            SizedBox(
                              width: 5,
                            ),
                          Text(
                            (controller.isSubscribe(channelId)) ? '구독중' : '구독',
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
    });
  }
}
