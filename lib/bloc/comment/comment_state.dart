import 'package:apple_shop_app/data/model/comment.dart';
import 'package:dartz/dartz.dart';

class CommentState {}

class CommentErrorState extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentResponseState extends CommentState {
  Either<String, List<Comment>> response;
  CommentResponseState(this.response);
}
