import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sykebe_clone/provider/user_provider.dart';
import 'package:sykebe_clone/screens/pageViews/chats/widgets/user_details_container.dart';
import 'file:///F:/Androidprojects/flutter_projects/sykebe_clone/lib/screens/them_screen/app_themes_screen.dart';
import 'package:sykebe_clone/utils/theams/theme_provider.dart';
import 'file:///F:/Androidprojects/flutter_projects/sykebe_clone/lib/utils/theams/universal_variables.dart';
import 'package:sykebe_clone/utils/utilities.dart';

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: UniversalVariables.blackColor,
        builder: (context)=>UserDetailsContainer(),
        isScrollControlled: true
      ),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(0xff272c35),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                Utils.getInitials(userProvider.getUser.name),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: UniversalVariables.lightBlueColor,
                  fontSize: 13,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color:themeProvider.themeMode().backgroundColor , width: 2),
                    color: UniversalVariables.onlineDotColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
