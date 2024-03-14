import 'package:beautyblock_app/home/screen/home_videoplayer_screen.dart';
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
    required this.thumbnail,
    required this.id,
  }) : super(key: key);

  // final imageUrl;
  final videoText;
  final followCount;
  final contentCount;
  final String thumbnail;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(() => HomeVideoplayerScreen(id: id));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLeftImageSection(),
              SizedBox(width: 4),
              _buildMiddleSection(),
              // _buildRightShareSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftImageSection() {
    return Container(
      height: 50,
      width: 75,
      child: Padding(
        padding: EdgeInsets.only(right: Get.width * 0.02),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              thumbnail,
              fit: BoxFit.cover,
            )),
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
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 12,
              ),
              SvgPicture.asset('assets/images/ic_heart2.svg'),
            ],
          ),
          Row(
            children: [
              Text(
                'Like : $followCount',
                style: AppTheme.tagTextStyle,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  '·',
                  style: AppTheme.tagTextStyle,
                ),
              ),
              Text(
                'Comment : $contentCount',
                style: AppTheme.tagTextStyle,
              ),
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
