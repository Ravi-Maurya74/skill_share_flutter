import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skill_share/blocs/create_post/create_post_bloc.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key, required this.communityName});
  final String communityName;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool initialValue = false;

  File? _image;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<CreatePostBloc, CreatePostState>(
        listener: (context, state) async {
          if (state is CreatePostSuccess) {
            var snackBar = const SnackBar(
              content: Text('Post Created Successfully!'),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            await Future.delayed(const Duration(seconds: 3),(){
              if (!context.mounted) {
              return;
            }
            Navigator.pop(context);
            });
          } else if (state is CreatePostError) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Okay'),
                  )
                ],
              ),
            );
          }
        },
        child: ScaffoldMessenger(
          key: _globalKey,
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text(
                          'Create Post',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            maxLength: 50,
                            controller: _titleController,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This feild  is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          if (_image != null)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(_image!),
                                ),
                              ],
                            ),
                          TextButton(
                            onPressed: _getImage,
                            child: const Text('Upload Image'),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF272727),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: TextFormField(
                              autofocus: false,
                              controller: _contentController,
                              maxLength: 400,
                              // style: Theme.of(context).textTheme.titleSmall,
                              minLines: 7,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: 'Description',
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This feild  is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFfb542b),
                            ),
                            onPressed: () async {
                              bool isValid = _formKey.currentState!.validate();
                              if (isValid) {
                                context.read<CreatePostBloc>().add(
                                      CreatePostRequest(
                                        title: _titleController.text,
                                        content: _contentController.text,
                                        community: widget.communityName,
                                        image: _image,
                                      ),
                                    );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Invalid Input'),
                                    content: const Text(
                                        "Make sure to enter all the required fields"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Okay'),
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Create',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
