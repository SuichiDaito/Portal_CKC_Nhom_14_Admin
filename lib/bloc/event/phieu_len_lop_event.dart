import 'package:equatable/equatable.dart';

abstract class PhieuLenLopEvent extends Equatable {
  const PhieuLenLopEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllPhieuLenLop extends PhieuLenLopEvent {}

class CreatePhieuLenLop extends PhieuLenLopEvent {
  final Map<String, dynamic> payload;

  const CreatePhieuLenLop(this.payload);

  @override
  List<Object?> get props => [payload];
}

class SubmitPhieuLenLop extends PhieuLenLopEvent {
  final Map<String, dynamic> payload;

  const SubmitPhieuLenLop(this.payload);

  @override
  List<Object?> get props => [payload];
}
