import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/authentication/authentication_bloc.dart';
import 'package:skill_share/data/models/user.dart';
import 'package:skill_share/presentation/widgets/profile_stack_design.dart';
import 'package:skill_share/presentation/widgets/user_detail_tile.dart';

class UserProfileTab extends StatefulWidget {
  const UserProfileTab({super.key});

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  @override
  Widget build(BuildContext context) {
    User user =
        (context.read<AuthenticationBloc>().state as Authenticated).user;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ProfileStackDesign(),
          Text(
            user.name,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(user.email, style: Theme.of(context).textTheme.bodyMedium!),
          const SizedBox(
            height: 25,
          ),
          Column(
            children: [
              UserdetailTile(
                Icons.account_circle_outlined,
                titleDescription: 'Edit your profile name and city',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'User profile',
                onPress: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((_) => BlocProvider.value(
                  //               value: context.read<UserBloc>(),
                  //               child: const EditProfileScreen(
                  //                   title: 'Edit User Profile'),
                  //             ))));
                },
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              // UserdetailTile(
              //   Icons.account_balance_wallet_outlined,
              //   titleDescription: 'View your total and category budgets',
              //   trailingIcon: Icons.chevron_right_outlined,
              //   title: 'Budget',
              //   onPress: () {},
              // ),
              // const Divider(
              //   thickness: 0.5,
              //   indent: 20,
              //   endIndent: 20,
              // ),
              UserdetailTile(
                Icons.bookmark_outline,
                titleDescription: 'See all the saved posts from community',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'Saved posts',
                onPress: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return BlocProvider(
                  //     create: (context) => CommunityPostListBloc(
                  //       authToken: context.read<AuthCubit>().state.authToken!,
                  //       dio: Dio(),
                  //       savedPosts: true,
                  //     ),
                  //     child: const CommunityTab(savedPosts: true),
                  //   );
                  // }));
                },
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              UserdetailTile(
                Icons.account_balance_outlined,
                titleDescription: 'See your monthly savings',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'Savings',
                onPress: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => const SavingsScreen())));
                },
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              UserdetailTile(Icons.receipt_outlined,
                  title: 'Dues History',
                  titleDescription: 'View all your cleared dues',
                  trailingIcon: Icons.chevron_right_outlined, onPress: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (_) => ClearedDuesScreen(
                //         user: context.read<UserBloc>().state.user!,
                //       ),
                //     ),
                //   );
              }),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              UserdetailTile(
                Icons.forum_outlined,
                titleDescription: 'View all your posts',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'My posts',
                onPress: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return BlocProvider(
                  //     create: (context) => CommunityPostListBloc(
                  //       authToken: context.read<AuthCubit>().state.authToken!,
                  //       dio: Dio(),
                  //       myPosts: true,
                  //     ),
                  //     child: const CommunityTab(myPosts: true),
                  //   );
                  // }));
                },
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              UserdetailTile(
                Icons.power_settings_new,
                titleDescription: 'Log out your profile',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'Log Out',
                onPress: () {
                  context.read<AuthenticationBloc>().add(LogOut());
                },
              ),
              // const SizedBox(
              //   height: 150,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
