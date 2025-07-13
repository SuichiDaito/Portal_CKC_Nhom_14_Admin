import 'package:chopper/chopper.dart';

class FormDataConverter extends JsonConverter {
  @override
  Request convertRequest(Request request) {
    if (request.parts.isNotEmpty) return request;
    return super.convertRequest(request);
  }
}
