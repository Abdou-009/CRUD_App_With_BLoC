import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_with_bloc/backend/postMod.dart';

@immutable
abstract class PostEvent extends Equatable {}

// Get All Posts
class LoadPostEvent extends PostEvent {
  @override
  List<Object?> get props => [];
}

// Add Posts
class AddPostEvent extends PostEvent {
  final int userd;
  final String title;
  final String body;

  AddPostEvent({
    required this.userd,
    required this.title,
    required this.body,
  });
  @override
  List<Object?> get props => [userd, title, body];
}

// Update Posts
class UpdatePostEvent extends PostEvent {
  final PostModel post;

  UpdatePostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

// Get by Id Posts
class GetByIdPostEvent extends PostEvent {
  final int id;

  GetByIdPostEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

// Delete by Id Posts
class DeletePostEvent extends PostEvent {
  final int id;

  DeletePostEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
