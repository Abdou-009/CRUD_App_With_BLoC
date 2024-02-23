import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:login_with_bloc/backend/postMod.dart';

@immutable
abstract class PostState extends Equatable {}

// PostLoadingState (init state)
class PostLoadingState extends PostState {
  @override
  List<Object?> get props => [];
}

// PostLoadedState
class PostLoadedState extends PostState {
  final List<PostModel> posts;

  PostLoadedState(this.posts);
  @override
  List<Object?> get props => [posts];
}

// PostErrorState
class PostErrorState extends PostState {
  final String errorMessage;

  PostErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

// PostByIdState
class PostByIdState extends PostState {
  final PostModel post;

  PostByIdState(this.post);
  @override
  List<Object?> get props => [post];
}
