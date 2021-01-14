part of 'surat_masuk_bloc.dart';

@immutable
abstract class SuratMasukState {}

class SuratMasukInitial extends SuratMasukState {}

class SuratMasukLoaded extends SuratMasukState {
  final ListSuratMasuk listSuratMasuk;

  SuratMasukLoaded(this.listSuratMasuk);
  
}