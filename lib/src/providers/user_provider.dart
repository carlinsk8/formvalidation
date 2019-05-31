import 'dart:convert';

import 'package:formvalidation/src/preferens/preferens_user.dart';
import 'package:http/http.dart' as http;
class UserProvider{

  final String _firebaseToken = "AIzaSyC8TaV_jza4STDVLypJbWDVC-z-CLe9kOU";
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async{
    final authData = {
      "email": email,
      "password":password,
      "returnSecureToken": true
    };

    final resp = await http.post(

      "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$_firebaseToken",
      body: json.encode(authData)

    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    //print(decodeResp);

    if(decodeResp.containsKey('idToken')){

      _prefs.token = decodeResp['idToken'];

      return {'ok': true, 'token': decodeResp['idToken']};

    }else{

      return {'ok': false, 'mensaje': decodeResp['error']['message']};

    }
  }

  Future<Map<String, dynamic>> newUser(String email, String password) async{

    final authData = {
      "email": email,
      "password":password,
      "returnSecureToken": true
    };

    final resp = await http.post(

      "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$_firebaseToken",
      body: json.encode(authData)

    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    //print(decodeResp);

    if(decodeResp.containsKey('idToken')){
      
      _prefs.token = decodeResp['idToken'];

      return {'ok': true, 'token': decodeResp['idToken']};

    }else{

      return {'ok': false, 'mensaje': decodeResp['error']['message']};

    }
  }

}