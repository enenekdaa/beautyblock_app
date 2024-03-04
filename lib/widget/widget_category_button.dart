import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryButtonWidget extends StatelessWidget {
  const CategoryButtonWidget({
    Key? key,
    required this.text,
    required this.index,
    required this.onPress,
    required this.isSelected,
  }) : super(key: key);

  final text;
  final index;
  final onPress;
  final isSelected;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      child: Text(
        text,
        style: AppTheme.smallTitleTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            color: isSelected
                ? GlobalBeautyColor.buttonHotPink
                : GlobalBeautyColor.middleBlack),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        minimumSize: Size.zero,
        backgroundColor: isSelected
            ? Color.fromRGBO(255, 236, 247, 1)
            : Color.fromRGBO(171, 169, 163, 0.16),
        side: isSelected
            ? BorderSide(color: GlobalBeautyColor.buttonHotPink)
            : BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
