// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_bloc_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminBlocState {

 int? get statusCode; String? get errorCode; Object? get error; User? get user; bool get isLoading; EAdminBlocStateAction get action;
/// Create a copy of AdminBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminBlocStateCopyWith<AdminBlocState> get copyWith => _$AdminBlocStateCopyWithImpl<AdminBlocState>(this as AdminBlocState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminBlocState&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.user, user) || other.user == user)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode,errorCode,const DeepCollectionEquality().hash(error),user,isLoading,action);

@override
String toString() {
  return 'AdminBlocState(statusCode: $statusCode, errorCode: $errorCode, error: $error, user: $user, isLoading: $isLoading, action: $action)';
}


}

/// @nodoc
abstract mixin class $AdminBlocStateCopyWith<$Res>  {
  factory $AdminBlocStateCopyWith(AdminBlocState value, $Res Function(AdminBlocState) _then) = _$AdminBlocStateCopyWithImpl;
@useResult
$Res call({
 int? statusCode, String? errorCode, Object? error, User? user, bool isLoading, EAdminBlocStateAction action
});




}
/// @nodoc
class _$AdminBlocStateCopyWithImpl<$Res>
    implements $AdminBlocStateCopyWith<$Res> {
  _$AdminBlocStateCopyWithImpl(this._self, this._then);

  final AdminBlocState _self;
  final $Res Function(AdminBlocState) _then;

/// Create a copy of AdminBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = freezed,Object? errorCode = freezed,Object? error = freezed,Object? user = freezed,Object? isLoading = null,Object? action = null,}) {
  return _then(_self.copyWith(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error ,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as EAdminBlocStateAction,
  ));
}

}


/// @nodoc


class _AdminBlocState extends AdminBlocState {
  const _AdminBlocState({this.statusCode = null, this.errorCode = null, this.error = null, this.user = null, this.isLoading = false, this.action = EAdminBlocStateAction.step1}): super._();
  

@override@JsonKey() final  int? statusCode;
@override@JsonKey() final  String? errorCode;
@override@JsonKey() final  Object? error;
@override@JsonKey() final  User? user;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  EAdminBlocStateAction action;

/// Create a copy of AdminBlocState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminBlocStateCopyWith<_AdminBlocState> get copyWith => __$AdminBlocStateCopyWithImpl<_AdminBlocState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminBlocState&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.user, user) || other.user == user)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode,errorCode,const DeepCollectionEquality().hash(error),user,isLoading,action);

@override
String toString() {
  return 'AdminBlocState(statusCode: $statusCode, errorCode: $errorCode, error: $error, user: $user, isLoading: $isLoading, action: $action)';
}


}

/// @nodoc
abstract mixin class _$AdminBlocStateCopyWith<$Res> implements $AdminBlocStateCopyWith<$Res> {
  factory _$AdminBlocStateCopyWith(_AdminBlocState value, $Res Function(_AdminBlocState) _then) = __$AdminBlocStateCopyWithImpl;
@override @useResult
$Res call({
 int? statusCode, String? errorCode, Object? error, User? user, bool isLoading, EAdminBlocStateAction action
});




}
/// @nodoc
class __$AdminBlocStateCopyWithImpl<$Res>
    implements _$AdminBlocStateCopyWith<$Res> {
  __$AdminBlocStateCopyWithImpl(this._self, this._then);

  final _AdminBlocState _self;
  final $Res Function(_AdminBlocState) _then;

/// Create a copy of AdminBlocState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = freezed,Object? errorCode = freezed,Object? error = freezed,Object? user = freezed,Object? isLoading = null,Object? action = null,}) {
  return _then(_AdminBlocState(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error ,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as EAdminBlocStateAction,
  ));
}


}

// dart format on
