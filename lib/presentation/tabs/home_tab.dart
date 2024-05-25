import 'package:flutter/material.dart';
import 'package:skill_share/presentation/widgets/community_post_list_builder.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Key key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Skill Share',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 19,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  key = UniqueKey();
                });
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: CommunityPostListBuilder(
          showJoinedButton: true,
          key: key,
        ));
  }
}
