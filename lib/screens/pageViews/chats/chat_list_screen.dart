import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sykebe_clone/provider/user_provider.dart';
import 'package:sykebe_clone/screens/callscreens/pickup/pickup_layout.dart';
import 'package:sykebe_clone/screens/pageViews/chats/widgets/chat_list_container.dart';
import 'package:sykebe_clone/screens/pageViews/chats/widgets/new_chat_botton.dart';
import 'package:sykebe_clone/screens/pageViews/chats/widgets/user_circle.dart';
import 'package:sykebe_clone/screens/them_screen/app_themes_screen.dart';
import 'package:sykebe_clone/utils/theams/theme_provider.dart';
import 'file:///F:/Androidprojects/flutter_projects/sykebe_clone/lib/utils/theams/universal_variables.dart';
import 'package:sykebe_clone/widgets/skype_appbar.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: themeProvider.themeMode().backgroundColor,
        appBar: SkypeAppBar(
          title: UserCircle(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: themeProvider.themeMode().appbarActionsColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/search_screen");
              },
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: themeProvider.themeMode().appbarActionsColor,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: UniversalVariables.blackColor,
                    builder: (context)=>AppThemes(),
                    isScrollControlled: true
                );
              },
            ),
          ],
        ),
        floatingActionButton: NewChatButton(),
        body: ChatListContainer(),
      ),
    );
  }
}
