import 'package:flutter/material.dart';
import 'package:skill_share/presentation/screens/streaming.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VideoCallScreen(
                            channelName: 'stream',
                          )));
            },
            child: const Text("Stream")),
      ),
    );
  }
}
