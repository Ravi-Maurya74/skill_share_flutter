import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/community_list/community_list_bloc.dart';
import 'package:skill_share/constants/decoration.dart';
import 'package:skill_share/presentation/widgets/community_card.dart';

class CommunityListTab extends StatelessWidget {
  const CommunityListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CommunityListBloc, CommunityListState>(
          bloc: CommunityListBloc(),
          builder: (context, state) {
            if (state is CommunityListLoading ||
                state is CommunityListInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CommunityListLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      decoration: kSearchTextFeild.copyWith(
                        hintText: 'Search Communities',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 186, 186, 186),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.communities.length,
                        itemBuilder: (context, index) {
                          return CommunityCard(
                            community: state.communities[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              print((state as CommunityListError).message);
              return const Center(child: Text('An error occurred'));
            }
          }),
    );
  }
}
