import 'package:chopper/chopper.dart';
import 'package:portal_ckc/api/services/chopper_services.dart';
import 'package:portal_ckc/api/services/converted_chopper.dart';
import 'package:portal_ckc/constant/string.dart';

class CallApi {
  static final chopper = ChopperClient(
    baseUrl: Uri.parse(ApiString.urlApi),
    services: [JsonService.create()],
    converter: ModelConverter(),
  );
  static JsonService get postServices => chopper.getService<JsonService>();
}
