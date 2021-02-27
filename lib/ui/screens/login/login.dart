import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pupr/blocs/authentication/authentication_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isLoading = false;

  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (ctx, state) {
          if(state is AuthError ){ 
            _scaffold.currentState.showSnackBar(
              SnackBar(
                  behavior: SnackBarBehavior.floating,
                content:Text( 'Gagal silahkan periksa username/password.'),
              action: SnackBarAction(label: 'close', onPressed: () {
                _scaffold.currentState.hideCurrentSnackBar();
              }),)
            );
          }
          if (state is AuthLoading) {
            setState(() {
              isLoading = true;
            });
          } else {
             setState(() {
              isLoading = false;
            });
          }
        },
        child: Stack(
          children: [
            Form(
              key: _form,
                          child: SizedBox.expand(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Image.asset(
                        'images/logo_pupr.jpg',
                        height: 150,
                      ),
                      SizedBox(height: 10,),
                      Text('Aplikasi Sistem \n Informasi Keciptakaryaan',
                        textAlign: TextAlign.center,
                       style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: _username,
                                  validator: (text) {
                                    if (text.isEmpty) {
                                      return 'Username tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Username',
                                      prefixIcon: Icon(Icons.person)),
                                ),
                                TextFormField(
                                  controller: _password,
                                  validator: (text) {
                                    if (text.isEmpty) {
                                      return 'Password tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      prefixIcon: Icon(Icons.lock_open)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 40,
                                  child: RaisedButton(
                                    color: Colors.green,
                                    onPressed: _loginPressed,
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:10
                      ),
                      Text('© Dinas Pekerjaan Umum dan Perumahan Rakyat', style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            isLoading ? SizedBox.expand(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: SpinKitDualRing(color: Colors.green),
                ),
              ),
            ) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
  void _loginPressed() {
    if (_form.currentState.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(AuthLogin(
        username: _username.text,
        password: _password.text
      ));
    }
  }
}
