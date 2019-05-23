import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final notifications;

  NotificationsPage({Key key, @required this.notifications}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Notificaciones')
      ),
      body: Column(
        children: List.generate(notifications.length, (index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.build),
                Text(notifications[index]['message']),
                Text('Hace ${DateTime.now().difference(DateTime.parse(notifications[index]['created_at'])).inDays} días.'),
              ]
            )
          );
        })
      )
    );
  }
}

