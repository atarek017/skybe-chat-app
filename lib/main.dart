import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sykebe_clone/provider/image_upload_provider.dart';
import 'package:sykebe_clone/provider/user_provider.dart';
import 'package:sykebe_clone/resourses/auth_methods.dart';
import 'package:sykebe_clone/screens/home_screen.dart';
import 'package:sykebe_clone/screens/login_screen.dart';
import 'package:sykebe_clone/screens/search_screen.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:sykebe_clone/utils/theams/theme_provider.dart';

void main() async {
  bool isLight = await getTheme();
  runApp(MyApp(isLight));
}

Future<bool> getTheme() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;

  print(isLightTheme);
  return isLightTheme;
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  bool isLight;

  MyApp(@required this.isLight);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(isLightTheme: widget.isLight))
      ],
      child: AppRun(),
    );
  }
}

class AppRun extends StatelessWidget {
  final AuthMethods _authMethods = AuthMethods();
  ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: "Chat app",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {'/search_screen': (context) => SearchScreen()},
      theme: themeProvider.themeData(),
      home: FutureBuilder(
        future: _authMethods.getCurrentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
