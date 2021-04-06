import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sykebe_clone/constants/strings.dart';
import 'package:sykebe_clone/models/call.dart';
import 'package:sykebe_clone/models/log.dart';
import 'package:sykebe_clone/models/user.dart';
import 'package:sykebe_clone/resourses/local_db/repository/log_repository.dart';
import 'package:sykebe_clone/screens/callscreens/call_screen.dart';
import 'package:sykebe_clone/resourses/call_methods.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({User from, User to, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );

    Log log = Log(
      callerName: from.name,
      callerPic: from.profilePhoto,
      callStatus: CALL_STATUS_DIALLED,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      timestamp: DateTime.now().toString(),
    );
    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      LogRepository.addLogs(log);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}
