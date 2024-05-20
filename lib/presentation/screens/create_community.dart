import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/blocs/create_community/create_community_bloc.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/community.dart';

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({super.key});

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool initialValue = false;
  int? selectedSkill;

  File? _bannerImage;
  File? _profileImage;

  List<Skill> skills = [];

  Future<void> _getBannerImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _bannerImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _getProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _fetchSkills() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      Response response = await Dio().get(
        SkillApiConstants.listCreateSkill,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      setState(() {
        skills = (response.data as List)
            .map((skill) => Skill.fromMap(skill))
            .toList();
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSkills();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<CreateCommunityBloc, CreateCommunityState>(
        listener: (context, state) {
          if (state is CreateCommunitySuccess) {
            Navigator.pop(context);
          } else if (state is CreateCommunityError) {
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
                        'Create Community',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                            label: Text('Name'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This feild  is required';
                            }
                            return null;
                          },
                        ),
                        DropdownButtonFormField<int?>(
                          hint: const Text('Skill'),
                          items: skills.map((Skill skill) {
                            return DropdownMenuItem<int?>(
                              value: skill.id,
                              child: Text(
                                  skill.name), // Display the name of the skill
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSkill = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'This feild  is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                if (_bannerImage != null)
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            FileImage(_bannerImage!),
                                      ),
                                    ],
                                  ),
                                TextButton(
                                  onPressed: _getBannerImage,
                                  child: const Text('Upload Banner Image'),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                if (_profileImage != null)
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            FileImage(_profileImage!),
                                      ),
                                    ],
                                  ),
                                TextButton(
                                  onPressed: _getProfileImage,
                                  child: const Text('Upload Profile Image'),
                                ),
                              ],
                            ),
                          ],
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
                              hintText: 'What this community is about ?',
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
                            if (isValid &&
                                _bannerImage != null &&
                                _profileImage != null) {
                              context.read<CreateCommunityBloc>().add(
                                    CreateCommunityRequest(
                                      name: _titleController.text,
                                      description: _contentController.text,
                                      banner: _bannerImage!,
                                      profile_image: _profileImage!,
                                      skill: selectedSkill!,
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
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
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
    );
  }
}
