import 'package:flutter/cupertino.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Something go wrong, try again later :(',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
