import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_bloc/backend/posts_repo.dart';
import 'package:login_with_bloc/blocks/app_bloc/app_bloc.dart';
import 'package:login_with_bloc/blocks/app_bloc/app_events.dart';
import 'package:login_with_bloc/blocks/app_bloc/app_states.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  final TextEditingController _userID = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => PostBloc(PostRepository())),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Page"),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
            child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Title", style: TextStyle(fontSize: 22)),
                  TextFormField(controller: _title),
                  const Text("Body", style: TextStyle(fontSize: 22)),
                  TextFormField(controller: _body),
                  const Text("UserID", style: TextStyle(fontSize: 22)),
                  TextFormField(
                    controller: _userID,
                    keyboardType:
                        TextInputType.number, // Ensure numeric keyboard
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly // Allow only digits
                    ],
                  ),
                  BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_title.text.isNotEmpty &&
                              _body.text.isNotEmpty &&
                              _userID.text.isNotEmpty) {
                            context.read<PostBloc>().add(AddPostEvent(
                                  userd: int.parse(_userID.text),
                                  title: _title.text,
                                  body: _body.text,
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Post Item added successfully !"),
                            ));
                            context.read<PostBloc>().add(LoadPostEvent());
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Please Fill The Text Field !"),
                            ));
                          }
                        },
                        child: const Text("Add Item"),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
