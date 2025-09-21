import 'package:apple_shop_app/data/datasource/comment_datasource.dart';
import 'package:apple_shop_app/data/model/comment.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComments(String productId);
}

class CommentRepository extends ICommentRepository {
  final ICommentDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      var response = await _datasource.getComments(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطایی در دریافت داده ها رخ داده!');
    } catch (ex) {
      return left('خطایی در دریافت داده ها رخ داده!');
    }
  }
}
