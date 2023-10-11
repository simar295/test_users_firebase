import 'package:flutter/material.dart';
import 'package:test_users_firebase/videocalling/joinn.dart';
import 'package:test_users_firebase/videocalling/videologin.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class groupCallPage extends StatelessWidget {
  const groupCallPage({
    Key? key,
    required this.callID,
  }) : super(key: key);

  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          487236221, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          'e415cfc0755459cd8f9aaf96ece5c1bfbdb88ba29418a60d85c8c45048c51e49', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: joinn.userid,
      userName: joinn.username,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.groupVideoCall()
        ..turnOnCameraWhenJoining = false
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
