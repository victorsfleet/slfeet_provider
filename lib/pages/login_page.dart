import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

import './dashboard_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    void _showAlert() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('Correo o contraseña incorrectos'),
            actions: <Widget>[
              FlatButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'S',
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(70.0, 110.0, 0.0, 0.0),
                    child: Text(
                      '·',
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                      )
                    )
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(100.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'Fleet',
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold
                      )
                    )
                  )
                ]
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      )
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Correo no puede estar vacio';
                      }
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      )
                    ),
                    obscureText: true,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Contraseña no puede estar vacio';
                      }
                    }
                  )
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
                    print(_emailController.text);
                    print(_passwordController.text);

                    _firebaseMessaging.getToken().then((token) {
                      final url = 'https://go.sfleet.mx/api/v2/authentications';
                      http.post(url, body: {'email': '${_emailController.text}', 'password': '${_passwordController.text}', 'device_token': '$token'}).then((response) {
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        if (response.statusCode == 200) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                        } else {
                          _showAlert();
                        }

                      });
                    });
                  }
                },
                child: Text('Submit'),
              )
            )
          ]
        )
      )
    );
  }
}
