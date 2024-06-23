import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:skill_share/blocs/create_post/create_post_bloc.dart';
import 'package:skill_share/blocs/create_session_bloc/create_session_bloc.dart';
import 'package:skill_share/data/models/list_session.dart';

class CreateSessionScreen extends StatefulWidget {
  const CreateSessionScreen({super.key, required this.communityName});
  final String communityName;

  @override
  State<CreateSessionScreen> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreateSessionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();
  bool initialValue = false;
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<CreateSessionBloc, CreateSessionState>(
        listener: (context, state) async {
          if (state is CreateSessionLoaded) {
            var snackBar = const SnackBar(
              content: Text('Post Created Successfully!'),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            await Future.delayed(const Duration(seconds: 3), () {
              if (!context.mounted) {
                return;
              }
              Navigator.pop(context);
            });
          } else if (state is CreateSessionError) {
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
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Time: ${formatDateTime(_dateTime)}"),
                              ElevatedButton(
                                  onPressed: () async {
                                    final DateTime dateTime =
                                        await dateTimePickerWidget(context);
                                    print(dateTime.toString());
                                    setState(() {
                                      _dateTime = dateTime;
                                    });
                                  },
                                  child: const Text("Select Time")),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Duration: '),
                              Expanded(
                                child: TextFormField(
                                                            maxLength: 2,
                                                            controller: _durationController,
                                                            decoration: const InputDecoration(
                                // label: Text('Title'),
                                                            ),
                                                            validator: (value) {
                                if (value==null || int.tryParse(value)==null) {
                                  return 'This feild  is required and should be integer.';
                                }
                                return null;
                                                            },
                                                          ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
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
                              controller: _descriptionController,
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
                              isValid =
                                  isValid && _dateTime.isAfter(DateTime.now());
                              if (isValid) {
                                context.read<CreateSessionBloc>().add(
                                    CreateSessionStarted(
                                        widget.communityName,
                                        _titleController.text,
                                        _descriptionController.text,
                                        _dateTime.toString(),
                                        int.tryParse(_durationController.text)!
                                        ),);
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

dateTimePickerWidget(BuildContext context) {
  return DatePicker.showDateTimePicker(
    context,
    currentTime: DateTime.now(),
  );
}

// function to format DateTime in more readable string

String formatDateTime(DateTime dateTime) {
  return DateFormat('dd-MM-yyyy - h:mm a').format(dateTime);
}
