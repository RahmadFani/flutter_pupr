import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pupr/helpers/api.dart';
import 'package:pupr/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthIsStart) {
      yield* _mapAuthIsStart();
    }
    if (event is AuthLogin) {
      yield* _mapAuthLogin(event);
    }
    if (event is AuthLogout) {
      yield* _mapAuthLogout();
    }
  }

  Stream<AuthenticationState> _mapAuthIsStart() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    if (token != '') {
      final userJson  = jsonDecode(prefs.getString('user') ?? Map<String, dynamic>()); 
      UserModel user = UserModel.fromJson(userJson);
      
      print(token);

      yield Authenticated(user);
    } else {
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapAuthLogin(AuthLogin event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    yield AuthLoading();

    try {
      final result = await http.post('$url_api/auth', 
      headers: {
        HttpHeaders.acceptHeader : 'application/json' 
      },
      body: {
        'username': event.username,
        'password': event.password
      });

      final json = jsonDecode(result.body);
      
      if (result.statusCode == 200) {
        final userJson = json['data']['user'];
        final token = json['data']['token'];
        userJson['token'] = token;
        prefs.setString('user', jsonEncode(userJson));
        prefs.setString('token', token);

        UserModel user = UserModel.fromJson(userJson);

        yield Authenticated(user);
        
      } else {
        log(json.toString());
        throw Error();
      }
      
    } catch (e) {
      log(e.toString());
      yield AuthError();
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapAuthLogout() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('user');
    yield UnAuthenticated();
  }
}
