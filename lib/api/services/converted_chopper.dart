import 'package:chopper/chopper.dart';
import 'package:flutter/rendering.dart';
import 'package:portal_ckc/api/model/comment.dart';
import 'dart:convert';

class ModelConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    if (request.parts.isNotEmpty) {
      return request;
    }

    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );
    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    var contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    var contentType = response.headers[contentTypeKey];
    var body = response.body;
    debugPrint("Body decodeJson: $body");

    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }

    try {
      final decoded = json.decode(body);

      // Trả về List nếu là List
      if (decoded is List) {
        return response.copyWith<BodyType>(body: decoded as BodyType);
      }

      // Trả về Map nếu là Map
      if (decoded is Map<String, dynamic>) {
        return response.copyWith<BodyType>(body: decoded as BodyType);
      }

      // Trường hợp khác (số, chuỗi,...)
      return response.copyWith<BodyType>(body: decoded as BodyType);
    } catch (e) {
      chopperLogger.warning('❌ JSON decode error: $e');
      return response.copyWith<BodyType>(body: body);
    }
  }

  // Response<BodyType> decodeJsonGogo<BodyType, InnerType>(Response response) {
  //   var contentType = response.headers[contentTypeKey];
  //   var body = response.body;
  //   debugPrint("Json: $body");
  //   if (contentType != null && contentType.contains(jsonHeaders)) {
  //     body = utf8.decode(response.bodyBytes);
  //   }
  //   try {
  //     var mapData = json.decode(body);
  //     if (mapData != null) {
  //       InfoLogin info = mapData.map((info) => InfoLogin.fromJson(info));
  //       return response.copyWith<BodyType>(body: info as BodyType);
  //     }
  //   } catch (e) {
  //     chopperLogger.warning(e);
  //     return response.copyWith<BodyType>(body: body);
  //   }
  //   return body;
  // }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }

  // Response<BodyType> convertResponseCompany<BodyType, InnerType>(
  //   Response response,
  // ) {
  //   return decodeJsonGogo<BodyType, InnerType>(response);
  // }
}
