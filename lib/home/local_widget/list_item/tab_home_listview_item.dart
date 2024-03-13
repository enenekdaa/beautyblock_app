import 'package:beautyblock_app/home/screen/home_videoplayer_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TabHomeListviewItem extends StatelessWidget {
  static const List<String> empty = [];
  TabHomeListviewItem({
    Key? key,
    // required this.imageWidget,
    required this.id,
    required this.duration,
    required this.videoTitle,
    required this.views,
    required this.date,
    this.thumbnail = '',
    this.tags = empty,
  }) : super(key: key);

  // final imageWidget;
  final id;
  int duration;
  final videoTitle;
  final views;
  final date;
  String thumbnail = '';
  List<String> tags;
  String tagString = '';

  @override
  Widget build(BuildContext context) {
    tagString = tags.map((e) => '#$e').join(' ');
    return Row(
      children: [
        Expanded(
          child: _buildListviewItem(),
        ),
      ],
    );
  }

  Widget _buildListviewItem() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: GestureDetector(
        onTap: () {
          Get.to(() => HomeVideoplayerScreen(id: id));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Container(height:Get.height * 0.25,child: Image.asset('assets/images/img_test_video_thumbnail.png',fit:BoxFit.cover,),decoration:BoxDecoration( borderRadius: BorderRadius.circular(10),)),
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: thumbnail == ''
                            ? Image.asset(
                                'assets/images/img_test_video_thumbnail.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                thumbnail,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ))
                  ],
                ),
                Positioned(
                  bottom: 7,
                  right: 5,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.0,
                      ), // 텍스트 주변 여백
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.7), // 배경색
                        borderRadius: BorderRadius.circular(5.0), // 둥근 모서리 반경
                      ),
                      child: Text(
                        formatDuration(duration),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'NatoSans',
                          height: 1.8,
                        ),
                      )),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              videoTitle,
              style: AppTheme.smallTitleTextStyle,
              maxLines: 1,
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
                SizedBox(
                  width: 5,
                ),
                Text(
                  tagString,
                  style: AppTheme.tagTextStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    // 1시간 미만인 경우 분:초 형식으로 반환
    if (hours == 0) {
      return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
    } else {
      // 1시간 이상인 경우 시:분:초 형식으로 반환
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
    }
  }
}
