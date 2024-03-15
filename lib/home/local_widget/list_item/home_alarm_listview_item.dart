import 'package:beautyblock_app/home/screen/home_videoplayer_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeAlarmListviewItem extends StatelessWidget {
  const HomeAlarmListviewItem({
    Key? key,
    required this.postId,
    required this.alarmTitle,
    required this.uploadDate,
    required this.image,
  });
  final postId;
  final image;
  final alarmTitle;
  final uploadDate;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HomeVideoplayerScreen(id: postId));
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: Get.width * 0.03),
              child: Container(
                height: 68,
                width: 68,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alarmTitle,
                  style: AppTheme.smallTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(formatDateString(uploadDate),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1.8,
                      fontFamily: 'NotoSans',
                    )),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
