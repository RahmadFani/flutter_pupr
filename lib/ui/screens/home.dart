import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pupr/blocs/authentication/authentication_bloc.dart';
import 'package:pupr/blocs/surat_masuk/surat_masuk_bloc.dart';
import 'package:pupr/models/user_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel user = (BlocProvider.of<AuthenticationBloc>(context).state as Authenticated).user ?? UserModel();
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Sistem Informasi Keciptakaryaan'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aplikasi Sistem Informasi Keciptakaryaan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 80, color: Colors.white,),
                      SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selamat Datang,', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),),
                          SizedBox(
                            height: 2,
                          ),
                          Text('${user.username}', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            
                          ),)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              onTap: () {
                 Navigator.pop(context);
                 Navigator.pushNamed(context, '/surat_masuk');
              },
              title: Text('Surat Masuk'),
            ),
            
            ListTile(
              onTap: () {
                Navigator.pop(context);
                BlocProvider.of<AuthenticationBloc>(context).add(AuthLogout());
                BlocProvider.of<SuratMasukBloc>(context).add(SuratMasukDispose());
              },
              leading: Icon(Icons.login),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Selamat Datang'),
      ),
    );
  }
}
