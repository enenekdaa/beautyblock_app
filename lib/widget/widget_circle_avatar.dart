import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    Key? key,
    required this.backgroundimage,
     this.text="",
     this.bottomTextIsVisible=false,
  
  })
      : super(key: key);

  final backgroundimage;
  final text;
  final bottomTextIsVisible;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: Get.height * 0.04,
            backgroundImage: backgroundimage??Image.asset('assets/images/img_main_logo.png'),
          ),
          SizedBox(height: Get.height * 0.01,),
          Visibility(
            visible: bottomTextIsVisible,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NotoSans',
                  color: Color.fromRGBO(170, 178, 183, 1)),
            ),
          )
        ],
      ),
    );
  }
}
