import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/community_list/community_list_bloc.dart';
import 'package:skill_share/constants/decoration.dart';
import 'package:skill_share/presentation/screens/create_community.dart';
import 'package:skill_share/presentation/widgets/community_card.dart';
import 'package:animations/animations.dart';

class CommunityListTab extends StatelessWidget {
  const CommunityListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        openBuilder: (context, action) => const CreateCommunity(),
      ),
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
