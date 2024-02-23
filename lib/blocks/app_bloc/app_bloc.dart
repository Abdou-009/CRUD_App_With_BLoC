import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_bloc/backend/postMod.dart';
import 'package:login_with_bloc/backend/posts_repo.dart';
import 'package:login_with_bloc/blocks/app_bloc/app_events.dart';
import 'package:login_with_bloc/blocks/app_bloc/app_states.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  PostBloc(this._postRepository) : super(PostLoadingState()) {
    // Get All Posts
    on<LoadPostEvent>((event, emit) async {
      emit(PostLoadingState());
      print("data is loading");
      try {
        final post = await _postRepository.getAllPost();
        emit(PostLoadedState(post));
        print("data is ready === ");
      } catch (e) {
        emit(PostErrorState(e.toString()));
        print("data is not found Error ---- ");
      }
    });

    // Add Posts
    on<AddPostEvent>((event, emit) async {
      try {
        await _postRepository.createPost(PostModel(
          id: event.userd,
          title: event.title,
          body: event.body,
        ));
        print("A new data is added with success +++ ");
      } catch (e) {
        emit(PostErrorState(e.toString()));
        print("data is not found Error ---- ");
      }
    });

    // Update Posts
    on<UpdatePostEvent>((event, emit) async {
      try {
        await _postRepository.updatePost(event.post);
        print("Update data is done with success +++ ");
      } catch (e) {
        emit(PostErrorState(e.toString()));
        print("data is not found Error ---- ");
      }
    });

    // Get by Id Posts Test =========

    // on<GetByIdPostEvent>((event, emit) async {
    //   try {
    //     await _postRepository.getPostById(event.id);
    //   } catch (e) {
    //     emit(PostErrorState(e.toString()));
    //     print("data is not found Error ---- ");
    //   }
    // });

    // Get by Id Posts
    on<GetByIdPostEvent>((event, emit) async {
      try {
        PostModel post = await _postRepository.getPostById(event.id);
        emit(PostByIdState(post));
        print(" data is finded with success  ");
      } catch (e) {
        emit(PostErrorState(e.toString()));
        print("data is not found Error ---- ");
      }
    });

    // Delete by Id Posts
    on<DeletePostEvent>((event, emit) async {
      try {
        await _postRepository.deletePost(event.id);
        print(" data is deleted with success  ");
        add(LoadPostEvent());
      } catch (e) {
        emit(PostErrorState(e.toString()));
        print("data is not found Error ---- ");
      }
    });
  }
}
