import 'package:flutter/material.dart';
import 'package:skill_share/data/models/community.dart';
import 'package:skill_share/presentation/widgets/community_post_list_builder.dart';

class CommunitySpecificScreen extends StatelessWidget {
  const CommunitySpecificScreen({super.key, required this.community});
  final Community community;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CommunityPostListBuilder(query: community.name,));
  }
}