import 'package:flutter/material.dart';
import 'package:skill_share/data/models/community.dart';
import 'package:skill_share/presentation/widgets/community_card.dart';
import 'package:skill_share/presentation/widgets/community_post_list_builder.dart';
import 'package:skill_share/presentation/widgets/join_button.dart';

class CommunitySpecificScreen extends StatelessWidget {
  const CommunitySpecificScreen({super.key, required this.community});
  final Community community;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0f0f0f),
          leading: IconButton(
            onPressed: () {},
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
        body: CommunityPostListBuilder(
          query: community.name,
        ),
      ),
    );
  }
}

//   SliverAppBar extendedAppBar(bool innerBoxScrolled) {
//     return SliverAppBar(
//       backgroundColor: const Color(0xFF0f0f0f),
//       leading: IconButton(
//         onPressed: () {},
//         icon: CircleAvatar(
//           backgroundColor: Colors.black.withOpacity(0.7),
//           child: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       flexibleSpace: Image.network(
//         community.banner,
//         fit: BoxFit.cover,
//       ),
//       bottom: PreferredSize(
//         preferredSize: const Size(double.infinity, 90),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: Container(
//               padding: const EdgeInsets.all(0),
//               width: 60.0,
//               height: 60.0,
//               child: CircleAvatar(
//                 backgroundImage: NetworkImage(community.banner),
//               ),
//             ),
//             title: Text(
//               community.name,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             subtitle: Text(
//               '${community.skill.name} • ${community.members.length} members',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//             ),
//             trailing: community.is_member ? null : const JoinButton(),
//           ),
//         ),
//       ),
//       pinned: true,
//       // floating: true,
//       forceElevated: innerBoxScrolled,
//     );
//   }

