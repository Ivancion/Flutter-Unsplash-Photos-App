import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarLogoPictureWidget extends StatelessWidget {
  const AppBarLogoPictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/unsplash_logo.svg',
      color: Colors.black,
      height: 26,
      width: 26,
    );
  }
}
