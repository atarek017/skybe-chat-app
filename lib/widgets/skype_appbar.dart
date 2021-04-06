import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sykebe_clone/utils/theams/theme_provider.dart';
import 'package:sykebe_clone/widgets/appbar.dart';

class SkypeAppBar extends StatelessWidget implements PreferredSizeWidget {

  final dynamic title;
  final List<Widget> actions;

  SkypeAppBar({
    Key key,
    @required this.title,
    @required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          color: themeProvider.themeMode().appbarActionsColor,
        ),
      ),
      centerTitle: true,
      title: title is String
          ? Text(title,
              style:
                  TextStyle(color: themeProvider.themeMode().textColor, fontWeight: FontWeight.bold))
          : title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
