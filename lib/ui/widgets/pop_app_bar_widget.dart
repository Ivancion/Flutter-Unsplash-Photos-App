import 'package:flutter/material.dart';
import 'package:unsplash_images/ui/widgets/app_bar_logo_picture_widget.dart';

class PopAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const PopAppBarWidget({
    Key? key,
    this.onIconPressed,
  }) : super(key: key);

  final void Function()? onIconPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onIconPressed ?? Navigator.of(context).pop,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const AppBarLogoPictureWidget(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
