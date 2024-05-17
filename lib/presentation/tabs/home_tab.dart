import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/list_post/list_post_bloc.dart';
import 'package:skill_share/presentation/widgets/community_post_list_builder.dart';
import 'package:skill_share/presentation/widgets/join_button.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CommunityPostListBuilder());
  }
}

