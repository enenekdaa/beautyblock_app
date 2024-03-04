import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeAlarmListviewItem extends StatelessWidget {
  const HomeAlarmListviewItem({
    Key? key,
    // required this.imageUrl,
    required this.alarmTitle,
    required this.uploadDate,
  });

  // final imageUrl;
  final alarmTitle;
  final uploadDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right:  Get.width * 0.03),
            child: Container(
              height: Get.height * 0.1,
              width:  Get.height * 0.1,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/images/img_test_video_thumbnail.png',fit: BoxFit.cover,),
                    ),
            ),
          ),
          Expanded(child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(alarmTitle,style:AppTheme.smallTitleTextStyle.copyWith(fontWeight: FontWeight.w500),softWrap: true,),
              SizedBox(height: 3,),
              Text(uploadDate,style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,height: 1.8,fontFamily: 'NotoSans',) ),
            ],
          ) )
        ],
      ),
    );
  }
}
