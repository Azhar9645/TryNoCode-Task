import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 120,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Image.asset('assets/icons/burger icon 2.png'),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('assets/icons/Search.png'),
              onPressed: () {},
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/Add User.png'),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset('assets/icons/mobile notification.png'),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset('assets/icons/Chat.png'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}