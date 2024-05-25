import 'package:flutter/material.dart';
import 'package:skill_share/data/models/list_session.dart';
import 'package:skill_share/presentation/screens/streaming.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key, required this.session});
  final ListSession session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sessions'),
        ),
        body: Column(
          children: [
            Text(session.description),
            Text(session.time),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VideoCallScreen(channelName: session.channel_id),
                      ));
                },
                child: const Text('Join Session'))
          ],
        ));
  }
}
