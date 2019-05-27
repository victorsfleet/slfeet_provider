import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/user.dart';

mixin UserModel on Model {
  User _authenticatedUser;

  User get user {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    //_authenticatedUser = User(userId: 14842, userType: 'provider', name: 'SAFETY CIRCLE', rating: 5, jwt: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNDg0Mn0.uwozZrJDUm92kZHRtSsCgfaUYlcqAmeWTx-9KTG1NyM');
    Map<String, dynamic> userData = {'error': true};
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    final String url = 'http://localhost:3000/api/v3/authentications';
    final String token = await _firebaseMessaging.getToken();
    final http.Response response = await http.post(url, body: {'email': '$email', 'password': '$password', 'device_token': '$token'});

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      _authenticatedUser = User(userId: res['user_id'], userType: res['user_type'], name: res['name'], rating: res['rating'], jwt: res['jwt']);
      userData['user'] = _authenticatedUser;
      userData['error'] = false;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', response.body);
    }

    return userData;
  }

  void auth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userData = prefs.getString('userData');

    if (userData != null) {
      final res = json.decode(userData);
      _authenticatedUser = User(userId: res['user_id'], userType: res['user_type'], name: res['name'], rating: res['rating'], jwt: res['jwt']);
    }
  }
}
