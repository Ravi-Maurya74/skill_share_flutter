import 'dart:math';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/authentication/authentication_bloc.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key, required this.channelName});
  final String channelName;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  AgoraClient? _client;

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  int _generateRandomUid() {
    return 100000 + Random().nextInt(100000);
  }

  Future<String?> getToken(
      {required String uid, required String channelName}) async {
    Response response = await Dio().post(
      'https://agora-token-service-production-f878.up.railway.app/getToken',
      data: {
        "tokenType": "rtc", // choose rtc for audio/video SDK tokens
        "role": "subscriber", // "publisher" or "subscriber"
        "uid": uid,
        "channel": channelName, // channel name, wildcard "*" is available.
        "expire": 3600 // optional: expiration time in seconds (default: 3600)
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: true,
      ),
    );
    return response.data['token'] as String?;
  }

  Future<void> _initAgora() async {
    int uid = _generateRandomUid();
    String? token =
        await getToken(uid: uid.toString(), channelName: widget.channelName);
    _client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
      appId: '12e002cdaf604554a3c88fd818771820',
      channelName: widget.channelName,
      tempToken: token,
      uid: uid,
      username:
          (BlocProvider.of<AuthenticationBloc>(context).state as Authenticated)
              .user
              .name,
    ));
    setState(() {
      _client = _client;
    });
    await _client!.initialize();
  }

  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Video Call'),
        ),
        body: _client == null
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Stack(
                  children: [
                    AgoraVideoViewer(
                      client: _client!,
                      layoutType: Layout.floating,
                      showNumberOfUsers: true,
                    ),
                    AgoraVideoButtons(
                      client: _client!,
                      enabledButtons: const [
                        BuiltInButtons.toggleCamera,
                        BuiltInButtons.switchCamera,
                        BuiltInButtons.callEnd,
                        BuiltInButtons.toggleMic,
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
