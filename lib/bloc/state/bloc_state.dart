import 'package:chopper/chopper.dart';
import 'package:portal_ckc/api/model/comment.dart';

abstract class BlocState {}

class LoadingData extends BlocState {}

class LoadedData extends BlocState {
  final Response<List<Comment>> comments;
  LoadedData(this.comments);
}

class ErroData extends BlocState {
  final String message;
  ErroData(this.message);
}
