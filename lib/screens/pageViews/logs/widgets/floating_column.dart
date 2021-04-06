import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///F:/Androidprojects/flutter_projects/sykebe_clone/lib/utils/theams/universal_variables.dart';
import 'package:sykebe_clone/utils/theams/theme_provider.dart';

class FloatingColumn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: UniversalVariables.fabGradient,
          ),
          child: Icon(
            Icons.dialpad,
            color: Colors.white,
            size: 25,
          ),
          padding: EdgeInsets.all(15),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeProvider.themeMode().backgroundColor,
              border: Border.all(
                width: 2,
                color: UniversalVariables.gradientColorEnd,
              )),
          child: Icon(
            Icons.add_call,
            color: UniversalVariables.gradientColorEnd,
            size: 25,
          ),
          padding: EdgeInsets.all(15),
        )
      ],
    );
  }
}