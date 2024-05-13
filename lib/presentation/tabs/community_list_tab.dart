import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/community_list/community_list_bloc.dart';

class CommunityListTab extends StatelessWidget {
  const CommunityListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CommunityListBloc, CommunityListState>(
          bloc: CommunityListBloc(),
          builder: (context, state) {
            if (state is CommunityListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CommunityListLoaded) {
              return ListView.builder(
                itemCount: state.communities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.communities[index].name),
                    subtitle: Text(state.communities[index].skill.name),
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         ChatScreen(chat: state.dms[index])));
                    },
                  );
                },
              );
            } else {
              // print((state as AllDmsError).message);
              return const Center(child: Text('An error occurred'));
            }
          }),
    );
  }
}
