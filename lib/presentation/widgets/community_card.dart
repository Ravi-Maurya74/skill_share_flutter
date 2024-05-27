import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/community_list/community_list_bloc.dart';
import 'package:skill_share/data/models/community.dart';
import 'package:skill_share/presentation/screens/community_specific_screen.dart';
import 'package:skill_share/presentation/widgets/join_button.dart';

class CommunityCard extends StatelessWidget {
  final Community community;
  final int index;
  const CommunityCard({required this.community, super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF272727),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(community.profile_image),
        ),
        title: Text(
          community.name,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white), //what if there are many skills
        ),
        subtitle: Text(
            '${community.skill.name} • ${community.members.length} members'),
        trailing: community.is_member ? null : JoinButton(
          onPressed: () {
            BlocProvider.of<CommunityListBloc>(context)
                .add(AddUserToCommunity(index));
          },
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommunitySpecificScreen(
                        community: community,
                      )));
        },
      ),
    );
  }
}
