import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';

class TagChipWidget extends StatelessWidget {
  const TagChipWidget({
    super.key,
    required this.tag,
    required this.onTap
  });

  final tag;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 236, 247, 1),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  tag,
                  style: AppTheme.smallTitleTextStyle.copyWith(color: GlobalBeautyColor.buttonHotPink),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: CircleAvatar(
                backgroundColor: GlobalBeautyColor.buttonHotPink,
                radius: 8.0,
                child: Icon(
                  Icons.clear,
                  size: 10.0,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }
}
