import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './notifications_page.dart';
import './profile_page.dart';
import './maintenance_service_request.dart';

class DashboardPage extends StatelessWidget {
  final userData;
  
  DashboardPage({Key key, @required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            tooltip: 'Notificaciones',
            onPressed: () {
              final url = 'http://localhost:3000/api/v3/notifications';
              http.get(url, headers: {HttpHeaders.authorizationHeader: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNDg0Mn0.uwozZrJDUm92kZHRtSsCgfaUYlcqAmeWTx-9KTG1NyM'}).then((response) {
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                if (response.statusCode == 200) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage(notifications: json.decode(response.body))));
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            tooltip: 'Mi cuenta',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          )
        ],
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(userData['name'])
              ]
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StarDisplay(value: userData['rating'])
              ],
            )
          ]
        )
      ),
      body: Container(
  margin: EdgeInsets.symmetric(vertical: 20.0),
  height: 160.0,
  child: ListView(
    scrollDirection: Axis.horizontal,
    children: <Widget>[
      Container(
        width: 160.0,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.calendar_today),
              Text('Solicitud de cita'),
              Text('Paso 1 de 7'),
              LinearProgressIndicator(backgroundColor: Colors.grey, value: 0.14)
            ]
          )
        )
      ),
      Container(
        width: 160.0,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.event_available),
              Text('Confirmar cita'),
              Text('Paso 2 de 7'),
              LinearProgressIndicator(backgroundColor: Colors.grey, value: 0.28)
            ]
          )
        )
      ),
      Container(
        width: 160.0,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.local_atm),
              Text('Presupuesto'),
              Text('Paso 3 de 7'),
              LinearProgressIndicator(backgroundColor: Colors.grey, value: 0.42)
            ]
          )
        )
      ),
      Container(
        width: 160.0,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.verified_user),
              Text('Autorización'),
              Text('Paso 4 de 7'),
              LinearProgressIndicator(backgroundColor: Colors.grey, value: 0.56)
            ]
          )
        )
      ),
      Container(
        width: 160.0,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.settings),
              Text('En proceso'),
              Text('Paso 5 de 7'),
              LinearProgressIndicator(backgroundColor: Colors.grey, value: 0.70)
            ]
          )
        )
      ),
      Container(
        width: 160.0,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.directions_car),
              Text('Entrega'),
              Text('Paso 6 de 7'),
              LinearProgressIndicator(backgroundColor: Colors.grey, value: 0.84)
            ]
          )
        )
      ),
      Container(
        width: 160.0,
        child: Card(
          child: InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.event_available),
                Text('Cierre'),
                Text('Paso 7 de 7'),
                LinearProgressIndicator(backgroundColor: Colors.grey, value: 1.0)
              ]
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MaintenanceServiceRequestPage()));
            }
          )
        )
      )
    ]
  )
)
    );
  }
}

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0}) : assert(value != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          color: Colors.yellow
        );
      }),
    );
  }
}
