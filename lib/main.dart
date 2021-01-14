import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pupr/blocs/authentication/authentication_bloc.dart';
import 'package:pupr/repositories/surat_masuk_repository.dart';
import 'package:pupr/ui/screens/home.dart';
import 'package:pupr/ui/screens/login/login.dart';
import 'package:pupr/ui/screens/surat_masuk/surat_masuk_index.dart';

import 'blocs/surat_masuk/surat_masuk_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthenticationBloc()..add(AuthIsStart())),
        BlocProvider(
            create: (context) =>
                SuratMasukBloc(suratMasukRepository: ApiSuratMasukRepository())..add(LoadSuratMasuk())
          )
      ],
      child: MaterialApp(
        title: 'Aplikasi Sistem Informasi Keciptakaryaan',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (ctx, state) {
          if (state is Authenticated) {
            return HomePage();
          } else {
            return LoginPage();
          }
        }),
        routes: {
          '/surat_masuk': (_) => SuratMasukIndexPage(),
        },
      ),
    );
  }
}
