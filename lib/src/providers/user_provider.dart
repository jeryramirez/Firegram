import 'dart:convert';

import 'package:http/http.dart' as http;


class UserProvider {

  final String _firebaseToken = ' AIzaSyDcSJs35eE-4idoLFE_3OqJbzLPO_rQ8i0 ';

  Future <Map<String, dynamic>> login( String email, String password) async {
    final authData = {

      'email' : email,
      'password' : password,
      'returnSecureToken' : true

    };


    final resp = await http.post('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
    body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);


    if (decodedResp.containsKey('idToken') ) {
      return { 
        'ok': true,
        'token' : decodedResp['idToken']
      };
    } else {
      return { 
        'ok': false,
        'token' : decodedResp['error']['message']
      };
    }
  }

  Future <Map<String, dynamic>> newUser( String email, String password) async {

    final authData = {

      'email' : email,
      'password' : password,
      'returnSecureToken' : true

    };


    final resp = await http.post('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
    body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);


    if (decodedResp.containsKey('idToken') ) {
      return { 
        'ok': true,
        'token' : decodedResp['idToken']
      };
    } else {
      return { 
        'ok': false,
        'token' : decodedResp['error']['message']
      };
    }
  }


}