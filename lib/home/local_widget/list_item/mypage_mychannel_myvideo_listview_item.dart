import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils.dart';

class MyPageMyChannelMyVideoListviewItem extends StatelessWidget {
  const MyPageMyChannelMyVideoListviewItem({
    Key?key,
    required this.image,
    required this.userName,
    required this.videoName,
    required this.views,
    required this.date,
  });

  final image;
  final userName;
  final videoName;
  final views;
  final date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:Get.height * 0.015),
      child: Row(
        children: [
          Flexible(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.only(right: Get.width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: Get.height * 0.015,
                        backgroundImage: image,
                      ),
                      SizedBox(width: Get.width * 0.01),
                      Text(
                        userName,
                        style: AppTheme.smallTitleTextStyle
                            .copyWith(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Text(
                    videoName,
                    style: AppTheme.smallTitleTextStyle
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                    softWrap: true,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/ic_eye.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        views,
                        style: AppTheme.tagTextStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                        child: Text(
                          '·',
                          style: AppTheme.tagTextStyle,
                        ),
                      ),
                      Text(
                        date,
                        style: AppTheme.tagTextStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.asset(
                  'assets/images/img_test_video_thumbnail.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
