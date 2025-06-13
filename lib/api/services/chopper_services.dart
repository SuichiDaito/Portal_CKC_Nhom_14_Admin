import 'package:chopper/chopper.dart';
import 'package:portal_ckc/api/model/comment.dart';

part 'chopper_services.chopper.dart';

// @ChopperApi(baseUrl: '/posts')
// abstract class JsonService extends ChopperService {
//   @GET()
//   Future<Response> getPosts();
//   static JsonService create([ChopperClient? client]) => _$JsonService(client);
// }

@ChopperApi(baseUrl: '/admin')
abstract class JsonService extends ChopperService {
  @GET()
  Future<Response<List<Comment>>> getComments();
  static JsonService create() => _$JsonService();
}
