import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChannelDetailVideoTabListviewItem extends StatelessWidget {
  const ChannelDetailVideoTabListviewItem({
    Key? key,
    // required this.imageUrl,
    required this.videoText,
    required this.followCount,
    required this.contentCount,
  }) : super(key: key);

  // final imageUrl;
  final videoText;
  final followCount;
  final contentCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Container(
        child: Row(
          children: [
            _buildLeftImageSection(),
            _buildMiddleSection(),
            _buildRightShareSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftImageSection() {
    return Container(
      height: Get.height * 0.06,
      child: Padding(
        padding: EdgeInsets.only(right: Get.width * 0.02),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset('assets/images/img_test_video_thumbnail.png')),
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                videoText,
                style: AppTheme.smallTitleTextStyle
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(width: Get.height * 0.02,),
              SvgPicture.asset('assets/images/ic_heart2.svg'),
            ],
          ),
          Row(
            children: [
              Text(
                'Follow : $followCount',
                style: AppTheme.tagTextStyle,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Text(
                  '·',
                  style: AppTheme.tagTextStyle,
                ),
              ),
              Text('Content : $contentCount'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRightShareSection() {
    return GestureDetector(
      child: SvgPicture.asset('assets/images/ic_share3.svg'),
    );
  }
}
