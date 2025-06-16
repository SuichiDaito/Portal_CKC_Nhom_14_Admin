import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portal_ckc/api/model/admin_thongtin.dart';

part 'admin_bloc_state.freezed.dart';

enum EStateValidation { success, unknownError, missingEmail }

enum EAdminBlocStateAction { step1, step2 }

@freezed
abstract class AdminBlocState with _$AdminBlocState {
  const AdminBlocState._();

  const factory AdminBlocState({
    @Default(null) int? statusCode,
    @Default(null) String? errorCode,
    @Default(null) Object? error,

    @Default(null) User? user,
    @Default(false) bool isLoading,

    @Default(EAdminBlocStateAction.step1) EAdminBlocStateAction action,
  }) = _AdminBlocState;
}
