import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TabChannelListviewItem extends StatelessWidget {
  const TabChannelListviewItem({
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
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
            child: Row(
              children: [
                _buildLeftImageSection(),
                _buildMiddleSection(),
                _buildRightShareSection(),
              ],
            ),
          ),
          Divider(thickness: 1,color: Color.fromRGBO(239, 239, 239, 1),)
        ],
      ),
    );
  }

  Widget _buildLeftImageSection() {
    return Container(
      padding: EdgeInsets.only(right: Get.width * 0.03),
      height: Get.height * 0.05, // 가능한 최대 너비
      child: AspectRatio(
        aspectRatio: 1 / 1, // 가로 세로 비율을 1:1로 설정
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록
                image: AssetImage(
                    'assets/images/img_test_video_thumbnail.png')), // 여기에 이미지 URL을 넣으세요.
          ),
        ),
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoText,
            style: AppTheme.smallTitleTextStyle
                .copyWith(fontWeight: FontWeight.w500),
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
              Text('Content : $contentCount',style: AppTheme.tagTextStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightShareSection() {
    return Row(
      children: [
        GestureDetector(
          child: SvgPicture.asset('assets/images/ic_heart2.svg'),
        ),
        Padding(
          padding: EdgeInsets.only(left: Get.height * 0.03),
          child: GestureDetector(
            child: SvgPicture.asset('assets/images/ic_share3.svg'),
          ),
        ),
      ],
    );
  }
}
