import 'package:apple_shop_app/data/model/comment.dart';
import 'package:dartz/dartz.dart';

class CommentState {}

class CommentErrorState extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentResponseState extends CommentState {
  final Either<String, List<Comment>> response;
  CommentResponseState(this.response);
}

class CommentPostLoadingState extends CommentState {
  final bool isLoading;
  CommentPostLoadingState(this.isLoading);
}

class CommentPostResponseState extends CommentState {
  final Either<String, String> response;
  CommentPostResponseState(this.response);
}
