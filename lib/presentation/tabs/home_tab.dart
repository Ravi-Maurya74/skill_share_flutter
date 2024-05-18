import 'package:flutter/material.dart';
import 'package:skill_share/presentation/widgets/community_post_list_builder.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: CommunityPostListBuilder(showJoinedButton: true));
  }
}
