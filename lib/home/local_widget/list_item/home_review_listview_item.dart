import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/model/firebase_reply_model.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_circle_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeReviewListviewItem extends StatelessWidget {
  const HomeReviewListviewItem({
    Key? key,
    required this.reply,
    required this.shareButtonOnPress,
    required this.postId,
    required this.likeButtonOnPress,
  }) : super(key: key);

  final BeautyReply reply;
  final shareButtonOnPress;
  final likeButtonOnPress;
  final postId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //leftSection
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.02, top: 8),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(reply.profile),
                  ),
                ),
                //middleSection
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '@${reply.nickName}',
                              style: AppTheme.tagTextStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.height * 0.01),
                              child: Text('·', style: AppTheme.tagTextStyle),
                            ),
                            Text(formatDateString(reply.createdAt),
                                style: AppTheme.tagTextStyle)
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(
                          reply.content,
                          style: AppTheme.smallTitleTextStyle,
                          softWrap: true,
                        ),
                        SizedBox(height: 3),
                        GestureDetector(
                          onTap: likeButtonOnPress,
                          behavior: HitTestBehavior.translucent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                reply.likes.contains(LoginController.to.getId())
                                    ? 'assets/images/ic_heart_active'
                                        '.svg'
                                    : 'assets/images/ic_heart_gray'
                                        '.svg',
                                height: 20,
                                width: 20,
                              ),
                              Text(
                                reply.likes.length.toString(),
                                style: AppTheme.tagTextStyle,
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              // SvgPicture.asset(
                              //   'assets/images/ic_text.svg',
                              //   color: GlobalBeautyColor.tagGray170,
                              // ),
                              // Text(
                              //   '답글 ${reviewCount}개',
                              //   style: AppTheme.tagTextStyle,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: shareButtonOnPress,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/images/ic_share2.svg'),
                    ))
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Color.fromRGBO(239, 239, 239, 1),
          )
        ],
      ),
    );
  }
}
