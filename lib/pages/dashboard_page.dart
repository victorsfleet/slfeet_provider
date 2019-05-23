import 'package:flutter/material.dart';
import './notifications_page.dart';
import './profile_page.dart';

import './maintenance_service_request.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            tooltip: 'Notificaciones',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
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
                Text('S · Fleet')
              ]
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                return Icon(Icons.star, color: Colors.yellow);
              })
            )
          ]
        )
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
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
              Expanded(
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
              )
            ]
          ),
          Row(
            children: <Widget>[
              Expanded(
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
              Expanded(
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
              )
            ]
          ),
          Row(
            children: <Widget>[
              Expanded(
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
              Expanded(
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
              )
            ]
          ),
          Row(
            children: <Widget>[
              Expanded(
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
        ]
      )
    );
  }
}
