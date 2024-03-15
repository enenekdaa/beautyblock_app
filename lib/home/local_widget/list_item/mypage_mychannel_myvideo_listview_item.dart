import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../model/firebase_post_model.dart';
import '../../../utils.dart';

class MyPageMyChannelMyVideoListviewItem extends StatelessWidget {
  const MyPageMyChannelMyVideoListviewItem({
    Key? key,
    required this.post,
    required this.userName,
    required this.userProfile,
  });

  final BeautyPost post;
  final userName;
  final userProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
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
                        backgroundImage: NetworkImage(userProfile),
                      ),
                      SizedBox(width: 8),
                      Text(
                        userName,
                        style: AppTheme.smallTitleTextStyle
                            .copyWith(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      post.title,
                      style: AppTheme.smallTitleTextStyle
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                      softWrap: true,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/ic_eye.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        post.viewCnt.toString(),
                        style: AppTheme.tagTextStyle,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                        child: Text(
                          '·',
                          style: AppTheme.tagTextStyle,
                        ),
                      ),
                      Text(
                        formatDateString(post.createdAt),
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
                child: Image.network(
                  post.thumbnail,
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
