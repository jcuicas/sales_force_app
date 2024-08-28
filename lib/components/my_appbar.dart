import 'package:flutter/material.dart';
import 'package:app_force_sales/inherited/my_inherited.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  final Widget? myButtonDrawer;

  const MyAppBar({
    super.key,
    this.myButtonDrawer,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        GetInfoUser.of(context).appTitle.toString(),
        style: const TextStyle(
          color: Color(0xffffffff),
        ),
      ),
      leading: widget.myButtonDrawer,
      backgroundColor: const Color(0xff000000),
      centerTitle: true,
      shape: const Border(
        bottom: BorderSide(
          color: Color(0xffec1c24),
          width: 3.0,
        ),
      ),
      elevation: 4,
    );
  }
}
