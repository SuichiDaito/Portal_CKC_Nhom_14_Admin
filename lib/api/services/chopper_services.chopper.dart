// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chopper_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$JsonService extends JsonService {
  _$JsonService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = JsonService;

  @override
  Future<Response<List<Comment>>> getComments() {
    final Uri $url = Uri.parse('/admin');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Comment>, Comment>($request);
  }
}
