import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    Key? key,
    required this.appbarText,
    this.centerTitle = false,
    this.actions,
  });

  final appbarText;
  final centerTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      titleSpacing: 0,
      leading: IconButton(
          icon: Image.asset('assets/images/ic_back_arrow.png'),
          onPressed: () => Get.back()),
      title: Text(appbarText,
          style: AppTheme.appBarTextStyle),
      // shape: Border(
      //   bottom: BorderSide(
      //     color: Color.fromRGBO(246, 246, 246, 1),
      //     width: 6,
      //   ),
      // ),
      bottom: PreferredSize(
                preferredSize: Size.fromHeight(6.0),
                child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius:2,
                        blurRadius: 3,
                        blurStyle: BlurStyle.inner,
                      ),
                ]))),
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
