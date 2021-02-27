import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pupr/models/surat_masuk.dart';
import 'package:pupr/repositories/surat_masuk_repository.dart';

part 'surat_masuk_event.dart';
part 'surat_masuk_state.dart';

class SuratMasukBloc extends Bloc<SuratMasukEvent, SuratMasukState> {
  final SuratMasukRepository suratMasukRepository;
  SuratMasukBloc({@required this.suratMasukRepository}) : super(SuratMasukInitial());

  @override
  Stream<SuratMasukState> mapEventToState(
    SuratMasukEvent event,
  ) async* {
    if (event is LoadSuratMasuk) {
      yield* _mapLoadSuratMasuk();
    }
    if (event is SuratMasukDispose) {
       yield SuratMasukInitial();
    }
  }

  Stream<SuratMasukState> _mapLoadSuratMasuk() async* {
    try {
      final listSuratMasuk = await this.suratMasukRepository.loadSuratMasuks();
      yield SuratMasukLoaded(listSuratMasuk);
    } catch (e) {
      yield SuratMasukInitial();
    }
  }
}
