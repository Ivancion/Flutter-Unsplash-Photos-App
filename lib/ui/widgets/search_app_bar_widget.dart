import 'package:flutter/material.dart';
import 'package:unsplash_images/ui/widgets/app_bar_logo_picture_widget.dart';

class SearchAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final void Function(String) onSubmitField;
  final String hintText;
  final void Function() onLogoutPressed;
  final void Function() onProfileBtnPressed;

  const SearchAppBarWidget(
      {Key? key,
      required this.onSubmitField,
      required this.hintText,
      required this.onLogoutPressed,
      required this.onProfileBtnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          const AppBarLogoPictureWidget(),
          const SizedBox(width: 14),
          Flexible(
            child: _AppBarTextField(
              onSubmitField: onSubmitField,
              hintText: hintText,
            ),
          ),
          const SizedBox(width: 14),
          _AppBarProfileBtn(onProfileBtnPressed: onProfileBtnPressed),
          const SizedBox(width: 12),
          _AppBarLogoutBtn(onLogoutPressed: onLogoutPressed),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}

class _AppBarTextField extends StatelessWidget {
  final void Function(String) onSubmitField;
  final String hintText;
  const _AppBarTextField(
      {Key? key, required this.onSubmitField, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitField,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        hintText: hintText,
        prefixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _AppBarProfileBtn extends StatelessWidget {
  const _AppBarProfileBtn({
    Key? key,
    required this.onProfileBtnPressed,
  }) : super(key: key);
  final void Function() onProfileBtnPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onProfileBtnPressed,
      icon: const Icon(
        Icons.person,
        color: Colors.grey,
      ),
    );
  }
}

class _AppBarLogoutBtn extends StatelessWidget {
  const _AppBarLogoutBtn({
    Key? key,
    required this.onLogoutPressed,
  }) : super(key: key);
  final void Function() onLogoutPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onLogoutPressed,
      icon: const Icon(
        Icons.exit_to_app,
        color: Colors.grey,
      ),
    );
  }
}
