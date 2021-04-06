import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sykebe_clone/screens/callscreens/pickup/pickup_layout.dart';
import 'package:sykebe_clone/screens/pageViews/logs/widgets/floating_column.dart';
import 'package:sykebe_clone/screens/pageViews/logs/widgets/log_list_container..dart';
import 'package:sykebe_clone/utils/theams/theme_provider.dart';
import 'package:sykebe_clone/widgets/skype_appbar.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: themeProvider.themeMode().backgroundColor,
        appBar: SkypeAppBar(
          title: "Calls",
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: themeProvider.themeMode().appbarActionsColor,
              ),
              onPressed: () => Navigator.pushNamed(context, "/search_screen"),
            ),
          ],
        ),
        floatingActionButton: FloatingColumn(),
        body: Padding(
          padding: EdgeInsets.only(left: 15),
          child: LogListContainer(),
        ),
      ),
    );
  }
}
