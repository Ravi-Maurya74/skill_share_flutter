import 'package:flutter/material.dart';

class UserdetailTile extends StatelessWidget {
  const UserdetailTile(this.leadingIcon,
      {super.key,
      required this.title,
      required this.titleDescription,
      required this.trailingIcon,
      required this.onPress});

  final String title;
  final String titleDescription;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        size: 32,
      ),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w500)),
      subtitle: Text(titleDescription,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w500)),
      trailing: Icon(trailingIcon),
      onTap: onPress,
    );
  }
}
