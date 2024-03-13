import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_circle_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeReviewListviewItem extends StatelessWidget {
  const HomeReviewListviewItem(
      {Key? key,
      required this.imageUrl,
      required this.nickName,
      required this.date,
      required this.reviewText,
      required this.reviewHeartCount,
      required this.reviewCount,
      required this.shareButtonOnPress,
      required this.postId,
      required this.id})
      : super(key: key);

  final imageUrl;
  final nickName;
  final date;
  final reviewText;
  final reviewHeartCount;
  final reviewCount;
  final shareButtonOnPress;
  final postId;
  final id;

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
                    backgroundImage: imageUrl,
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
                              '@${nickName}',
                              style: AppTheme.tagTextStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.height * 0.01),
                              child: Text('·', style: AppTheme.tagTextStyle),
                            ),
                            Text(date, style: AppTheme.tagTextStyle)
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(
                          reviewText,
                          style: AppTheme.smallTitleTextStyle,
                          softWrap: true,
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/ic_heart.svg',
                              color: GlobalBeautyColor.tagGray170,
                            ),
                            Text(
                              reviewHeartCount,
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
