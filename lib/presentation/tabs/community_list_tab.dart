import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/community_list/community_list_bloc.dart';
import 'package:skill_share/blocs/create_community/create_community_bloc.dart';
import 'package:skill_share/constants/decoration.dart';
import 'package:skill_share/presentation/screens/create_community.dart';
import 'package:skill_share/presentation/widgets/community_card.dart';
import 'package:animations/animations.dart';

class CommunityListTab extends StatefulWidget {
  const CommunityListTab({super.key});

  @override
  State<CommunityListTab> createState() => _CommunityListTabState();
}

class _CommunityListTabState extends State<CommunityListTab> {
  Key key = UniqueKey();
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
        openBuilder: (context, action) => BlocProvider<CreateCommunityBloc>(
          create: (context) => CreateCommunityBloc(),
          child: const CreateCommunity(),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
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
      body: BlocBuilder<CommunityListBloc, CommunityListState>(
        key: key,
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
