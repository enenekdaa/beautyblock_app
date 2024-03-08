import 'package:flutter/material.dart';

class SNSJoinButtonWidget extends StatelessWidget {
  const SNSJoinButtonWidget({
    Key?key,
    required this.snsIcon,
    required this.onPress
  }) :super(key: key);

  final onPress;
  final snsIcon;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPress, icon: snsIcon);
  }
}
