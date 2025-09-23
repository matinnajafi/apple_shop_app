abstract class CommentEvent {}

class CommentInitializeEvent extends CommentEvent {
  String productId;
  CommentInitializeEvent(this.productId);
}

class CommentPostEvent extends CommentEvent {
  String productId;
  String comment;
  CommentPostEvent(this.productId, this.comment);
}
