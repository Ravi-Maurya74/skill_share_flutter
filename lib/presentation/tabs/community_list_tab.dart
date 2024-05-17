import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/community_list/community_list_bloc.dart';
import 'package:skill_share/constants/decoration.dart';

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
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // TextField(
                    //   decoration: kSearchTextFeild.copyWith(
                    //     hintText: 'Search',
                    //     prefixIcon: const Icon(
                    //       Icons.search,
                    //       color: Color.fromARGB(255, 186, 186, 186),
                    //     ),
                    //   ),
                    //   onChanged: (value) {},
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.communities.length,
                        itemBuilder: (context, index) {
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
                              leading: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/Meeting2.png'),
                              ),
                              title: Text(
                                state.communities[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Colors
                                            .white), //what if there are many skills
                              ),
                              subtitle: Text(
                                  '${state.communities[index].skill.name} • ${state.communities[index].members.length} members'),
                              trailing: state.communities[index].is_member
                                  ? null
                                  : const JoinButton(),
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         ChatScreen(chat: state.dms[index])));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // print((state as AllDmsError).message);
              return const Center(child: Text('An error occurred'));
            }
          }),
    );
  }
}

class JoinButton extends StatelessWidget {
  const JoinButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your logic here
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFfb542b),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          'Join',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
