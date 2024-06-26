import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/all_dms/all_dms_bloc.dart';
import 'package:skill_share/blocs/authentication/authentication_bloc.dart';
import 'package:skill_share/blocs/search_user/search_user_bloc.dart';
import 'package:skill_share/data/models/chat.dart';
import 'package:skill_share/data/models/user.dart';
import 'package:skill_share/presentation/screens/chat_screen.dart';
import 'package:skill_share/presentation/screens/search_user.dart';
import 'package:skill_share/constants/decoration.dart';

class DmsTab extends StatelessWidget {
  const DmsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllDmsBloc>(
      create: (context) => AllDmsBloc(),
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
          openBuilder: (context, action) => BlocProvider<SearchUserBloc>(
            create: (context) => SearchUserBloc(),
            child: const SelectOtherUser(),
          ),
        ),
        body: BlocBuilder<AllDmsBloc, AllDmsState>(builder: (context, state) {
          if (state is AllDmsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllDmsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: kSearchTextFeild.copyWith(
                      hintText: 'Search',
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
                  Text(' Messages', style: titleStyle),
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.dms.length,
                      itemBuilder: (context, index) {
                        final Chat chat = state.dms[index];
                        final User currentUser = (context.read<AuthenticationBloc>().state as Authenticated).user;
                        final User otherParticipant = getOtherParticipant(chat.participants, currentUser);
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                otherParticipant.picture),
                          ),
                          title: Text(otherParticipant.name),
                          subtitle:
                              Text(otherParticipant.email),
                          trailing: Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: const BoxDecoration(
                              color: Color(0xFFfb542b),
                              shape: BoxShape.circle,
                            ),
                          ),
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ChatScreen(chat: state.dms[index])));
                            context.read<AllDmsBloc>().add(FetchUpdateAllDms());
                          },
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
      ),
    );
  }
}
