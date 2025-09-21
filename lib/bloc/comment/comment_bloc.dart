import 'package:apple_shop_app/bloc/comment/comment_event.dart';
import 'package:apple_shop_app/bloc/comment/comment_state.dart';
import 'package:apple_shop_app/data/repository/comment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository _repository;

  CommentBloc(this._repository) : super(CommentLoadingState()) {
    on<CommentInitializeEvent>((event, emit) async {
      final response = await _repository.getComments(event.productId);
      emit(CommentResponseState(response));
    });
  }
}
