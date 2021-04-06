import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:sykebe_clone/enum/user_state.dart';
import 'package:sykebe_clone/provider/user_provider.dart';
import 'package:sykebe_clone/resourses/auth_methods.dart';
import 'package:sykebe_clone/resourses/local_db/repository/log_repository.dart';
import 'package:sykebe_clone/screens/pageViews/chats/chat_list_screen.dart';
import 'package:sykebe_clone/screens/pageViews/logs/log_screen.dart';
import 'file:///F:/Androidprojects/flutter_projects/sykebe_clone/lib/utils/theams/universal_variables.dart';
import 'package:sykebe_clone/utils/theams/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> with WidgetsBindingObserver {
  int currentIndex = 0;
  List<Widget> _widgetList = [
    ChatListScreen(),
    LogScreen(),
    Center(
        child: Text(
      "Contact Screen",
      style: TextStyle(color: Colors.white),
    )),
  ];

  UserProvider userProvider;
  final AuthMethods _authMethods = AuthMethods();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();
      _authMethods.setUserState(
        userId: userProvider.getUser.uid,
        userState: UserState.Online,
      );

      LogRepository.init(isHive: false, dbName: userProvider.getUser.uid);
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId =
        (userProvider != null && userProvider.getUser != null)
            ? userProvider.getUser.uid
            : "";

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("detached state");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.themeMode().backgroundColor,
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: themeProvider.themeMode().backgroundColor,
        selectedIndex: currentIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.call),
              title: Text('Calls'),
              activeColor: Colors.pink),
          BottomNavyBarItem(
              icon: Icon(Icons.contact_phone),
              title: Text('Contacts'),
              activeColor: Colors.purple),
        ],
      ),
      body: _widgetList[currentIndex],
    );
  }
}
