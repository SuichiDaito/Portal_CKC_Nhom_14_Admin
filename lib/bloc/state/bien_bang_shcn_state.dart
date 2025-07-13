import 'package:portal_ckc/api/model/admin_bien_bang_shcn.dart';

abstract class BienBanState {}

class BienBanInitial extends BienBanState {}

class BienBanLoading extends BienBanState {}

class BienBanLoaded extends BienBanState {
  final List<BienBanSHCN> bienBanList;

  BienBanLoaded(this.bienBanList);
}

class BienBanActionSuccess extends BienBanState {
  final String message;

  BienBanActionSuccess(this.message);
}

class BienBanError extends BienBanState {
  final String message;

  BienBanError(this.message);
}

class BienBanFormLoaded extends BienBanState {
  final Map<String, dynamic> formData;
  BienBanFormLoaded(this.formData);
}

class BienBanDetailLoaded extends BienBanState {
  final BienBanSHCN bienBan;

  BienBanDetailLoaded(this.bienBan);
}

class MeetingMinutesCreateDataLoading extends BienBanState {}

class MeetingMinutesCreateDataLoaded extends BienBanState {
  final MeetingMinutesCreateData data;

  MeetingMinutesCreateDataLoaded(this.data);
}

class MeetingMinutesCreateDataError extends BienBanState {
  final String message;

  MeetingMinutesCreateDataError(this.message);
}
