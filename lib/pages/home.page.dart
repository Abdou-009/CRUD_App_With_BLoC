import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_bloc/backend/postMod.dart';
import 'package:login_with_bloc/backend/posts_repo.dart';
import 'package:login_with_bloc/blocks/app_bloc/app_bloc.dart';
import 'package:login_with_bloc/blocks/app_bloc/app_events.dart';
import 'package:login_with_bloc/blocks/app_bloc/app_states.dart';
import 'package:login_with_bloc/pages/add.page.dart';
import 'package:login_with_bloc/pages/edit.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => PostBloc(PostRepository()),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Home Page"),
            backgroundColor: Colors.teal,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddPage()),
                  );
                },
                icon: const Icon(Icons.add_circle_outline),
              )
            ],
          ),
          body: BlocProvider(
            create: (context) =>
                PostBloc(PostRepository())..add(LoadPostEvent()),
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PostLoadedState) {
                  List<PostModel> postList = state.posts;
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditPage(
                                        id: postList[index].id.toString(),
                                      )),
                            );
                          },
                          child: Card(
                            color: Colors.lightGreen,
                            child: ListTile(
                              title: Text(
                                '${postList[index].title}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              subtitle: Text(
                                '${postList[index].body}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text(postList[index].id.toString(),
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  context.read<PostBloc>().add(
                                      DeletePostEvent(id: postList[index].id!));
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is PostErrorState) {
                  return const Center(
                    child: Text("Error Occur !"),
                  );
                }
                return Container();
              },
            ),
          ),
        ));
  }
}
