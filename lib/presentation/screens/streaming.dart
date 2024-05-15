import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget { 
const VideoCallScreen({super.key}); 

@override 
State<VideoCallScreen> createState() => _VideoCallScreenState(); 
} 

class _VideoCallScreenState extends State<VideoCallScreen> { 
final AgoraClient _client = AgoraClient( 
	agoraConnectionData: AgoraConnectionData( 
	appId: '12e002cdaf604554a3c88fd818771820', 
	channelName: 'stream', 
	tempToken: 
		'007eJxSYLi5qExdLjrXTqHgAtMHzxshGxZdvP0o5Ow+t/wjbupfz4YrMBgapRoYGCWnJKaZGZiYmpokGidbWKSlWBhamJsbWhgZlH90SRPgY2BgYeJlZWRgZGBhYGQA8ZnAJDOYZAGTbAzFJUWpibmMDAaAAAAA//+fTx7A', 
)); 

@override 
void initState() { 
	super.initState(); 
	_initAgora(); 
} 

Future<void> _initAgora() async { 
	await _client.initialize(); 
} 

@override 
Widget build(BuildContext context) { 
	return WillPopScope( 
	onWillPop: () async => false, 
	child: Scaffold( 
		appBar: AppBar( 
			title: const Text('Video Call'), 
		), 
		body: SafeArea( 
			child: Stack( 
			children: [ 
				AgoraVideoViewer( 
				client: _client, 
				layoutType: Layout.floating, 
				showNumberOfUsers: true, 
				), 
				AgoraVideoButtons( 
				client: _client, 
				enabledButtons: const [ 
					BuiltInButtons.toggleCamera, 
					BuiltInButtons.switchCamera, 
					BuiltInButtons.callEnd, 
					BuiltInButtons.toggleMic, 
				], 
				) 
			], 
			), 
		)), 
	); 
} 
}
