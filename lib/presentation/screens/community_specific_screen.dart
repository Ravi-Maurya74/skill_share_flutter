import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/create_post/create_post_bloc.dart';
import 'package:skill_share/constants/decoration.dart';
import 'package:skill_share/data/models/community.dart';
import 'package:skill_share/presentation/screens/create_post.dart';
import 'package:skill_share/presentation/widgets/community_post_list_builder.dart';
import 'package:skill_share/presentation/widgets/join_button.dart';
import 'package:skill_share/presentation/widgets/session_list_builder.dart';

class CommunitySpecificScreen extends StatelessWidget {
  const CommunitySpecificScreen({super.key, required this.community});
  final Community community;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: OpenContainer(
          transitionDuration: const Duration(milliseconds: 500),
          transitionType: ContainerTransitionType.fadeThrough,
          closedShape: const CircleBorder(),
          // closedColor: const Color(0xFF50559a),
          closedColor: const Color(0xFFfb542b), //Color(0xFFFF4500),
          //Color(0xFFFF5B00) //#FF4500
          openColor: Theme.of(context)
              .scaffoldBackgroundColor, //const Color(0xFF16161e),
          middleColor: const Color(0xFFd988a1),
          closedBuilder: (context, action) => Container(
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFfb542b),
            ),
            child: const Icon(
              Icons.add,
              size: 25,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          openBuilder: (context, action) => BlocProvider<CreatePostBloc>(
            create: (context) => CreatePostBloc(),
            child: CreatePost(
              communityName: community.name,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0f0f0f),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.7),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          flexibleSpace: Column(
            children: [
              Image.network(
                community.banner,
                fit: BoxFit.cover,
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 90),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(0),
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(community.banner),
                  ),
                ),
                title: Text(
                  community.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${community.skill.name} • ${community.members.length} members',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                trailing: community.is_member ? null : const JoinButton(),
              ),
            ),
          ),
        ),
        body: CommunitySpecificScreenTabs(community: community),
      ),
    );
  }
}

class CommunitySpecificScreenTabs extends StatefulWidget {
  const CommunitySpecificScreenTabs({super.key, required this.community});
  final Community community;

  @override
  State<CommunitySpecificScreenTabs> createState() =>
      _CommunitySpecificScreenTabsState();
}

class _CommunitySpecificScreenTabsState
    extends State<CommunitySpecificScreenTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'Posts',
                style: titleStyle.copyWith(fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                'Sessions',
                style: titleStyle.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              CommunityPostListBuilder(
                query: widget.community.name,
              ),
              SessionListBuilder(
                community: widget.community,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
