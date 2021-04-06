import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sykebe_clone/models/contact.dart';
import 'package:sykebe_clone/models/user.dart';
import 'package:sykebe_clone/provider/user_provider.dart';
import 'package:sykebe_clone/resourses/auth_methods.dart';
import 'package:sykebe_clone/resourses/chat_methods.dart';
import 'package:sykebe_clone/screens/chatscreens/screen_chat.dart';
import 'package:sykebe_clone/screens/chatscreens/wedgets/cached_network_image.dart';
import 'package:sykebe_clone/utils/theams/theme_provider.dart';
import 'file:///F:/Androidprojects/flutter_projects/sykebe_clone/lib/utils/theams/universal_variables.dart';
import 'package:sykebe_clone/widgets/custom_tile.dart';

import 'last_message_container.dart';
import '../../../../widgets/online_dot_Indecator.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final AuthMethods _authMethods = AuthMethods();
  ThemeProvider themeProvider;
  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<User>(
      future: _authMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ViewLayout(
            contact: user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final ChatMethods _chatMethods = ChatMethods();

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiver: contact,
            ),
          )),
      title: Text(
        (contact != null ? contact.name : null) != null ? contact.name : "..",
        style:
        TextStyle(color:themeProvider.themeMode().textColor, fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
          senderId: userProvider.getUser.uid,
          receiverId: contact.uid,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(
              uid: contact.uid,
            ),
          ],
        ),
      ),
    );
  }
}