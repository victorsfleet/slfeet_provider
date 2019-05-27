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
//print(userData);
    Container flowSteps(IconData icon, String title, int step) {
      return Container(
        width: 160.0,
        child: Card(
          child: InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon),
                Text(title),
                Text('Paso $step de 7'),
                LinearProgressIndicator(backgroundColor: Colors.grey, value: step/7)
              ]
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MaintenanceServiceRequestPage()));
            }
          )
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            tooltip: 'Notificaciones',
            onPressed: () {
              final url = 'http://localhost:3000/api/v3/notifications';
              http.get(url, headers: {HttpHeaders.authorizationHeader: userData.jwt}).then((response) {
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
                Text(userData.name)
              ]
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StarDisplay(value: userData.rating)
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
            flowSteps(Icons.calendar_today, 'Solicitud de cita', 1),
            flowSteps(Icons.event_available, 'Confirmar cita', 2),
            flowSteps(Icons.local_atm, 'Presupuesto', 3),
            flowSteps(Icons.verified_user, 'Autorización', 4),
            flowSteps(Icons.settings, 'En proceso', 5),
            flowSteps(Icons.directions_car, 'Entrega', 6),
            flowSteps(Icons.event_available, 'Cierre', 7),
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
