
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/authentication/authentication_bloc.dart';

class ProfileStackDesign extends StatelessWidget {
  const ProfileStackDesign({super.key});

  @override
  Widget build(BuildContext context) {
    String? profilePic =
        (context.read<AuthenticationBloc>().state as Authenticated)
            .user
            .picture;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.26,
        ),
        Container(
          height: screenHeight * 0.2,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF50559a),
                  Color(0xFFd988a1),

                  //50559a
                ]),
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(
                    MediaQuery.of(context).size.width, 250.0)),
          ),
        ),
        Positioned(
          top: screenHeight * 0.11,
          left: screenHeight * 0.168,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 201, 200, 200),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 8)
              ],
            ),
            child: GestureDetector(
              onTap: () {
                // showDialog(
                //   context: context,
                //   builder: (_) {
                //     return AlertDialog(
                //       content: ChangeProfilePicWidget(
                //         profilePic: profilePic,
                //         userBloc: context.read<UserBloc>(),
                //       ),
                //     );
                //   },
                // );
              },
              child: CircleAvatar(
                backgroundColor: const Color(0xFFfafafa),
                backgroundImage: profilePic == null
                    ? null
                    : CachedNetworkImageProvider(
                        profilePic,
                      ),
                radius: 60,
                child: profilePic == null
                    ? const Icon(
                        Icons.person_sharp,
                        size: 80,
                        color: Color(0xFFd988a1),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// class ChangeProfilePicWidget extends StatefulWidget {
//   const ChangeProfilePicWidget({
//     super.key,
//     required this.profilePic,
//     required this.userBloc,
//   });

//   final String? profilePic;
//   final UserBloc userBloc;

//   @override
//   State<ChangeProfilePicWidget> createState() => _ChangeProfilePicWidgetState();
// }

// class _ChangeProfilePicWidgetState extends State<ChangeProfilePicWidget> {
//   File? _image;

//   Future<void> _getImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         GestureDetector(
//           onTap: () {
//             if (_image == null && widget.profilePic == null) {
//               return;
//             }
//             showDialog(
//               context: context,
//               builder: (_) {
//                 return AlertDialog(
//                   content: _image != null
//                       ? Image.file(_image!)
//                       : CachedNetworkImage(
//                           imageUrl: widget.profilePic!,
//                           placeholder: (context, url) =>
//                               const CircularProgressIndicator(),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                         ),
//                 );
//               },
//             );
//           },
//           child: CircleAvatar(
//             backgroundColor: const Color(0xFFfafafa),
//             backgroundImage: _image != null
//                 ? FileImage(_image!) as ImageProvider<Object>
//                 : widget.profilePic == null
//                     ? null
//                     : CachedNetworkImageProvider(
//                         widget.profilePic!,
//                       ),
//             radius: 90,
//             child: _image == null && widget.profilePic == null
//                 ? const Icon(
//                     Icons.person_sharp,
//                     size: 80,
//                     color: Color(0xFFd988a1),
//                   )
//                 : null,
//           ),
//         ),
//         if (_image != null)
//           TextButton(
//             onPressed: () {
//               // update the profile pic
//               widget.userBloc.add(UserUpdate({'profile_pic': _image}));
//               Navigator.pop(context);
//             },
//             child: const Text('Update'),
//           ),
//         TextButton(
//           onPressed: _getImage,
//           child: const Text('Upload New Image'),
//         ),
//         if (_image == null && widget.profilePic != null)
//           TextButton(
//             onPressed: () {
//               // update the profile pic
//               widget.userBloc.add(const UserUpdate({'profile_pic': null}));
//               Navigator.pop(context);
//             },
//             child: const Text('Remove Current Profile Pic'),
//           ),
//       ],
//     );
//   }
// }