import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverlappingImagesWidget extends StatelessWidget {
  const OverlappingImagesWidget({
    Key? key,
    required this.image,
  });

  final image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: Get.height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: image,
            ),
          ),
        ),
        Container(
          height: Get.height * 0.25,
          width: Get.height * 0.25,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: image),
          ),
        ),
      ],
    );
  }
}
