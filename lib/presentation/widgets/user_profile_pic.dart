import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfilePic extends StatelessWidget {
  const UserProfilePic({super.key, this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? const Icon(
            Icons.account_circle,
            size: 35,
          )
        : GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return CachedNetworkImage(
                    imageUrl: url!,
                    placeholder: (context, url) => const Center(
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  );
                },
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(url!),
            ),
          );
  }
}
