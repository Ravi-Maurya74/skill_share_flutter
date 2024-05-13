import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/search_user/search_user_bloc.dart';
import 'package:skill_share/constants/decoration.dart';
import 'package:skill_share/data/models/chat.dart';
import 'package:skill_share/data/models/user.dart';
import 'package:skill_share/data/repositories/chat_repository.dart';
import 'package:skill_share/presentation/screens/chat_screen.dart';
import 'package:skill_share/presentation/widgets/user_profile_pic.dart';

class SelectOtherUser extends StatelessWidget {
  const SelectOtherUser({super.key});

  void _onSelectingUser(User user,BuildContext context)async{
    Chat chat = await ChatRepository.createChat(type: "dm", participants: [user.uid]);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(chat: chat)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Other User',
          style: titleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            decoration:
                InputDecoration(labelText: 'Search', labelStyle: bodyStyle),
            onChanged: (value) {
              if (value.length > 2) {
                context.read<SearchUserBloc>().add(SearchEvent(value));
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder<SearchUserBloc, SearchUserState>(
              builder: (context, state) {
                if (state is SearchUserSuccess) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          // Navigator.of(context).pop(state.users[index]);
                          _onSelectingUser(state.users[index], context);
                        },
                        leading:
                            UserProfilePic(url: state.users[index].picture),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.users[index].name,
                              style: bodyStyle,
                            ),
                            Text(
                              state.users[index].email,
                              style: bodyStyle.copyWith(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .fontSize),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is SearchUserInitial) {
                  return Container();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
