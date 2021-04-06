
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'file:///F:/Androidprojects/flutter_projects/sykebe_clone/lib/utils/theams/universal_variables.dart';

class ShimmeringLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: Shimmer.fromColors(
        baseColor: UniversalVariables.blackColor,
        highlightColor: Colors.white,
        child: Image.asset("assets/app_logo.png"),
        period: Duration(seconds: 1),
      ),
    );
  }
}