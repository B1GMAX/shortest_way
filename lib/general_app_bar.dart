import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? width;
  final bool isHomePage;
  final String text;

  const GeneralAppBar({
    this.width = 200,
    this.isHomePage = false,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Row(
        children: [
          if (!isHomePage)
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          if (isHomePage) const SizedBox(width: 15),
          const Text(
            'Process Screen',
          ),
        ],
      ),
      leadingWidth: width,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
