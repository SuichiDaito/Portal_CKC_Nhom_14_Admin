import 'package:portal_ckc/api/controller/call_api.dart';
import 'package:portal_ckc/bloc/state/bloc_state.dart';
import 'package:portal_ckc/bloc/event/bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocImplement extends Bloc<BlocEvent, BlocState> {
  BlocImplement() : super(LoadingData()) {
    on<FetchData>(_onFetchData);
    on<RefreshData>(_onRefreshData);
  }

  Future<void> _onFetchData(FetchData event, Emitter<BlocState> emit) async {
    try {
      final comment = await CallApi.postServices.getComments();
      emit(LoadedData(comment));
    } catch (e) {
      emit(ErroData(e.toString()));
    }
  }

  Future<void> _onRefreshData(RefreshData event, Emitter<BlocState> emit) async {
    try {
      final comment = await CallApi.postServices.getComments();
      emit(LoadedData(comment));
    } catch (e) {
      emit(ErroData(e.toString()));
    }
  }
}
