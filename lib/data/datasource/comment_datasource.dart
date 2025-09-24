import 'package:apple_shop_app/data/model/comment.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/api_exception.dart';
import 'package:apple_shop_app/util/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class ICommentDatasource {
  Future<List<Comment>> getComments(String productId);
  Future<void> postComment(String productId, String comment);
}

class CommentRemoteDatasource extends ICommentDatasource {
  final Dio _dio = locator.get();
  final String userId = AuthManager.getId();

  @override
  Future<List<Comment>> getComments(String productId) async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'product_id="$productId"',
        'expand': 'user_id', // expand relations
        'perPage': 600, // get a lot of comments!
      };
      var response = await _dio.get(
        'collections/comment/records',
        queryParameters: qParams,
      );
      return (response.data['items'] as List)
          .map<Comment>((jsonObject) => Comment.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.data['code'],
        ex.response?.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      final response = await _dio.post(
        'collections/comment/records',
        data: {'text': comment, 'user_id': userId, 'product_id': productId},
      );
      print('statusssss: ${response.statusCode}'); // test line for debug
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
